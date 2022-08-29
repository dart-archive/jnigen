import 'dart:io';

import 'package:path/path.dart';
import 'package:jni/jni.dart';
import 'dart:ffi';

import 'package:pdfbox_plugin/org/apache/pdfbox/pdmodel.dart';

void writeInfo(String file) {
  var jni = Jni.getInstance();

  // var inputFile = new FileInputStream(file)
  var inputFile = jni
      .newInstance("java/io/FileInputStream", "(Ljava/lang/String;)V", [file]);
  var inputJl = JlObject.fromRef(inputFile.jobject);

  // pdDoc = PDDocument.load(inputFile)
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
  final libPath = dirname(dirname(Platform.script.toFilePath()));
  final jarPath = join(dirname(libPath), 'mvn_jar');
  final jars = Directory(jarPath)
      .listSync()
      .map((entry) => entry.path)
      .where((path) => path.endsWith('.jar'))
      .toList();
  Jni.spawn(helperDir: jniLibsDir, classPath: jars);
  if (arguments.length != 1) {
    stderr.writeln('usage: dart run bin/dart_example.dart <Path_to_PDF>');
    exitCode = 1;
    return;
  }
  writeInfo(arguments[0]);
}
