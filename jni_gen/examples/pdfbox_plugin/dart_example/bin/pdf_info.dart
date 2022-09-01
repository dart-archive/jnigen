import 'dart:io';

import 'package:path/path.dart';
import 'package:jni/jni.dart';
import 'dart:ffi';

import 'package:pdfbox_plugin/third_party/org/apache/pdfbox/pdmodel.dart';

void writeInfo(String file) {
  var jni = Jni.getInstance();

  var inputFile = jni
      .newInstance("java/io/FileInputStream", "(Ljava/lang/String;)V", [file]);
  var inputJl = JlObject.fromRef(inputFile.jobject);

  var pdDoc = PDDocument.load7(inputJl);
  int pages = pdDoc.getNumberOfPages();
  final info = pdDoc.getDocumentInformation();
  final title = info.getTitle();
  final subject = info.getSubject();
  final author = info.getAuthor();
  stderr.writeln('Number of pages: $pages');
  if (title.reference != nullptr) {
    stderr.writeln('Title: ${title.toDartString()}');
  }
  if (subject.reference != nullptr) {
    stderr.writeln('Subject: ${subject.toDartString()}');
  }
  if (author.reference != nullptr) {
    stderr.writeln('Author: ${author.toDartString()}');
  }
  stderr.writeln('PDF Version: ${pdDoc.getVersion()}');

  for (JlObject jr in [pdDoc, info, title, author, subject]) {
    jr.delete();
  }
  inputFile.delete();
}

final jniLibsDir = join('build', 'jni_libs');

void main(List<String> arguments) {
  final jarPath = join('..', 'mvn_jar');
  List<String> jars;
  try {
    jars = Directory(jarPath)
        .listSync()
        .map((entry) => entry.path)
        .where((path) => path.endsWith('.jar'))
        .toList();
  } on OSError catch (e) {
    stderr.writeln(e);
    stderr.writeln('Please download JAR files in plugin directory.');
    stderr.writeln('`dart run jni_gen:download_maven_jars --config '
        'jni_gen.yaml`');
    stderr.writeln('or alternatively regenerate bindings so that '
        'JARs will be automatically downloaded');
    return;
  }
  Jni.spawn(helperDir: jniLibsDir, classPath: jars);
  if (arguments.length != 1) {
    stderr.writeln('usage: dart run pdf_info:pdf_info <Path_to_PDF>');
    exitCode = 1;
    return;
  }
  writeInfo(arguments[0]);
}
