package com.github.hegde.mahesh.apisummarizer.doclet;

import com.github.hegde.mahesh.apisummarizer.elements.ClassDecl;
import com.github.hegde.mahesh.apisummarizer.elements.Method;
import com.github.hegde.mahesh.apisummarizer.elements.Package;
import com.github.hegde.mahesh.apisummarizer.util.Log;
import com.github.hegde.mahesh.apisummarizer.util.SkipException;
import java.util.*;
import javax.lang.model.SourceVersion;
import javax.lang.model.element.*;
import javax.lang.model.util.ElementScanner9;
import jdk.javadoc.doclet.Doclet;
import jdk.javadoc.doclet.DocletEnvironment;
import jdk.javadoc.doclet.Reporter;

public class SummarizerDocletBase implements Doclet {
  private AstEnv utils;

  @Override
  public void init(Locale locale, Reporter reporter) {}

  @Override
  public String getName() {
    return "ApiSummarizer";
  }

  @Override
  public Set<? extends Option> getSupportedOptions() {
    return Collections.emptySet();
  }

  @Override
  public SourceVersion getSupportedSourceVersion() {
    return SourceVersion.RELEASE_11;
  }

  public static List<ClassDecl> types;

  @Override
  public boolean run(DocletEnvironment docletEnvironment) {
    Log.timed("Initializing doclet");
    utils = AstEnv.fromEnvironment(docletEnvironment);
    SummarizingScanner p = new SummarizingScanner();
    docletEnvironment.getSpecifiedElements().forEach(e -> p.scan(e, new SummaryCollector()));
    types = p.types;
    return true;
  }

  public static class SummaryCollector {
    Stack<Package> packages = new Stack<>();
    Stack<ClassDecl> types = new Stack<>();
    Method method;
  }

  public class SummarizingScanner extends ElementScanner9<Void, SummaryCollector> {
    List<Package> packages = new ArrayList<>();
    List<ClassDecl> types = new ArrayList<>();
    ElementBuilders builders = new ElementBuilders(utils);

    // Each element in collector is a stack
    // which is used to get topmost element
    // and append the child to it.
    // Eg: A variable element is always appended to topmost
    // class
    @Override
    public Void scan(Element e, SummaryCollector collector) {
      return super.scan(e, collector);
    }

    @Override
    public Void visitPackage(PackageElement e, SummaryCollector collector) {
      Log.verbose("Visiting package: %s", e.getQualifiedName());
      collector.packages.push(new Package());
      System.out.println("package: " + e.getQualifiedName());
      var result = super.visitPackage(e, collector);
      var collectedPackage = collector.packages.pop();
      packages.add(collectedPackage);
      return result;
    }

    @Override
    public Void visitType(TypeElement e, SummaryCollector collector) {
      // Supposedly it should visit every type only once.
      // super.visitType visits the enclosed types and it should do that once.
      // but its visiting nested classes twice.
      // This could be a bug in my code, or something related to traversal order.
      //
      // Btw, the stack is useless now
      // TODO: remove stack
      if (!collector.types.isEmpty()) {
        return null;
      }
      Log.verbose("Visiting class: %s, %s", e.getQualifiedName(), collector.types);
      switch (e.getKind()) {
        case CLASS:
        case INTERFACE:
        case ENUM:
          try {
            var cls = builders.classDecl(e);
            collector.types.push(cls);
            super.visitType(e, collector);
            types.add(collector.types.pop());
          } catch (SkipException skip) {
            Log.always("Skip type: %s", e.getQualifiedName());
          }
          break;
        case ANNOTATION_TYPE:
          Log.always("Skip annotation type: %s", e.getQualifiedName());
          break;
      }
      return null;
    }

    @Override
    public Void visitVariable(VariableElement e, SummaryCollector collector) {
      var vk = e.getKind();
      var cls = collector.types.peek();
      switch (vk) {
        case ENUM_CONSTANT:
          cls.values.add(e.getSimpleName().toString());
          break;
        case FIELD:
          cls.fields.add(builders.field(e));
          break;
        case PARAMETER:
          if (collector.method == null) {
            throw new RuntimeException("Parameter encountered outside executable element");
          }
          var method = collector.method;
          method.params.add(builders.param(e));
          break;
        default:
          System.out.println("Unknown type of variable element: " + vk);
      }
      return null;
    }

    @Override
    public Void visitExecutable(ExecutableElement element, SummaryCollector collector) {
      var cls = collector.types.peek();
      switch (element.getKind()) {
        case METHOD:
        case CONSTRUCTOR:
          try {
            var method = builders.method(element);
            collector.method = method;
            super.visitExecutable(element, collector);
            collector.method = null;
            cls.methods.add(method);
          } catch (SkipException skip) {
            Log.always("Skip method: %s", element.getSimpleName());
          }
          break;
        case STATIC_INIT:
          cls.hasStaticInit = true;
          break;
        case INSTANCE_INIT:
          cls.hasInstanceInit = true;
          break;
      }
      return null;
    }
  }
}
