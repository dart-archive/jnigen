import 'package:jni_gen/src/elements/elements.dart';
import 'dart:io';

enum NestedClassRenameStrategy {
  underscore,
  concat,
}

enum OverloadRenameStrategy {
  numbering,
  numberingWithDefault,
}

abstract class ClassFilter {
  bool included(ClassDecl decl);
}

class CustomClassFilter implements ClassFilter {
  CustomClassFilter(this.predicate);
  final bool Function(ClassDecl) predicate;
  @override
  bool included(ClassDecl decl) {
    return predicate(decl);
  }
}

bool _matchesCompletely(String string, Pattern pattern) {
  final match = pattern.matchAsPrefix(string);
  return match != null && match.group(0) == string;
}

class ClassNameFilter implements ClassFilter {
  ClassNameFilter.include(this.pattern) : onMatch = true;
  ClassNameFilter.exclude(this.pattern) : onMatch = false;
  final bool onMatch;
  final Pattern pattern;
  @override
  bool included(ClassDecl decl) {
    if (_matchesCompletely(decl.binaryName, pattern)) {
      return onMatch;
    }
    return !onMatch;
  }
}

abstract class MemberFilter<T extends ClassMember> {
  bool included(ClassDecl classDecl, T member);
}

class MemberNameFilter<T extends ClassMember> implements MemberFilter<T> {
  MemberNameFilter.include(this.classPattern, this.namePattern)
      : onMatch = true;
  MemberNameFilter.exclude(this.classPattern, this.namePattern)
      : onMatch = false;
  final bool onMatch;
  final Pattern classPattern, namePattern;
  @override
  bool included(ClassDecl classDecl, T member) {
    final matches = _matchesCompletely(classDecl.binaryName, classPattern) &&
        _matchesCompletely(member.name, namePattern);
    return matches ? onMatch : !onMatch;
  }
}

class CustomMemberFilter<T extends ClassMember> implements MemberFilter<T> {
  CustomMemberFilter(this.predicate);
  bool Function(ClassDecl, T) predicate;
  @override
  bool included(ClassDecl classDecl, T member) => predicate(classDecl, member);
}

class CombinedClassFilter implements ClassFilter {
  CombinedClassFilter.all(this.filters);

  final List<ClassFilter> filters;
  @override
  bool included(ClassDecl decl) {
    final res = filters.every((f) => f.included(decl));
    stderr.writeln(res);
    return res;
  }
}

class CombinedMemberFilter<T extends ClassMember> implements MemberFilter<T> {
  CombinedMemberFilter(this.filters);

  final List<MemberFilter<T>> filters;

  @override
  bool included(ClassDecl decl, T member) {
    return filters.every((f) => f.included(decl, member));
  }
}

typedef FieldFilter = MemberFilter<Field>;
typedef MethodFilter = MemberFilter<Method>;

typedef FieldNameFilter = MemberNameFilter<Field>;
typedef MethodNameFilter = MemberNameFilter<Method>;

typedef CustomFieldFilter = CustomMemberFilter<Field>;
typedef CustomMethodFilter = CustomMemberFilter<Method>;

typedef CombinedFieldFilter = CombinedMemberFilter<Field>;
typedef CombinedMethodFilter = CombinedMemberFilter<Method>;

class WrapperOptions {
  /// Options for jni_gen.
  /// Note: not all configuration options are now implemented.
  const WrapperOptions({
    this.useGlobalReferences = true,
    this.classFilter,
    this.fieldFilter,
    this.methodFilter,
    this.classTransformer,
    this.methodTransformer,
    this.fieldTransformer,
    this.importPaths = const {},
    this.nestedClassRenameStrategy = NestedClassRenameStrategy.underscore,
    this.overloadRenameStrategy = OverloadRenameStrategy.numbering,
  });

  // PackageName -> ImportPath mappings
  // eg : 'org.apache.pdfbox' -> 'package:pdfbox/'
  // for default package - +packagename.dart
  // for nested packages - +path/packagename.dart
  // for nested packages
  final Map<String, String> importPaths;

  /// use JNI global references everywhere, default is true
  final bool useGlobalReferences;

  final ClassFilter? classFilter;
  final FieldFilter? fieldFilter;
  final MethodFilter? methodFilter;

  // If the transformer function returns null, nothing would be generated
  final ClassDecl? Function(ClassDecl decl)? classTransformer;
  final Method? Function(Method method)? methodTransformer;
  final Field? Function(Field field)? fieldTransformer;

  // these will be overridden if transformer functions are specified
  final NestedClassRenameStrategy nestedClassRenameStrategy;
  final OverloadRenameStrategy overloadRenameStrategy;
}
