// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:jni_gen/src/bindings/bindings.dart';

import 'package:jni_gen/src/elements/elements.dart';
import 'package:jni_gen/src/config/wrapper_options.dart';
import 'package:jni_gen/src/util/find_package.dart';

import 'bindings_writer.dart';

// Writes dart files to specified directory
// The name of the files themselves is decided by package name
class FilesWriter extends BindingsWriter {
  static const _initFileName = 'init.dart';

  FilesWriter(
      {required this.cWrapperDir,
      required this.dartWrappersRoot,
      this.javaWrappersRoot,
      this.preamble,
      required this.libraryName});
  Uri cWrapperDir, dartWrappersRoot;
  Uri? javaWrappersRoot;
  String? preamble;
  String libraryName;
  @override
  Future<void> writeBindings(
      Iterable<ClassDecl> classes, WrapperOptions options) async {
    // If the file already exists, show warning.
    // sort classes so that all classes get written at once.
    final Map<String, List<ClassDecl>> packages = {};
    final Map<String, ClassDecl> classesByName = {};
    for (var c in classes) {
      classesByName.putIfAbsent(c.binaryName, () => c);
      packages.putIfAbsent(c.packageName!, () => <ClassDecl>[]);
      packages[c.packageName!]!.add(c);
    }
    final classNames = classesByName.keys.toSet();

    stderr.writeln('Creating dart init file ...');
    final initFileUri = dartWrappersRoot.resolve(_initFileName);
    final initFile = await File.fromUri(initFileUri).create(recursive: true);
    await initFile.writeAsString(DartPreludes.initFile(libraryName),
        flush: true);

    final cFile = await File.fromUri(cWrapperDir.resolve('$libraryName.c'))
        .create(recursive: true);
    final cFileStream = cFile.openWrite();
    if (preamble != null) {
      cFileStream.writeln(preamble);
    }
    cFileStream.write(CPreludes.prelude);
    final preprocessor = ApiPreprocessor(classesByName, options);
    preprocessor.preprocessAll();
    for (var packageName in packages.keys) {
      final relativeFileName = '${packageName.replaceAll('.', '/')}.dart';
      final dartFileUri = dartWrappersRoot.resolve(relativeFileName);
      stderr.writeln('Writing bindings for $packageName...');
      final dartFile = await File.fromUri(dartFileUri).create(recursive: true);
      final resolver = PackagePathResolver(
          options.importPaths, packageName, classNames,
          predefined: {'java.lang.String': 'jni.JlString'});
      final cgen = CBindingGenerator(options);
      final dgen = DartBindingsGenerator(options, resolver);

      final package = packages[packageName]!;
      final cBindings = package.map(cgen.generateBinding).toList();
      final dartBindings = package.map(dgen.generateBinding).toList();
      // write imports from bindings
      final dartFileStream = dartFile.openWrite();
      final initImportPath = ('../' *
              relativeFileName.codeUnits
                  .where((cu) => '/'.codeUnitAt(0) == cu)
                  .length) +
          _initFileName;
      if (preamble != null) {
        dartFileStream.writeln(preamble);
      }
      dartFileStream
        ..write(DartPreludes.bindingFileHeaders)
        ..write(resolver.getImportStrings().join('\n'))
        ..write('import "$initImportPath" show jlookup;\n\n');
      // write dart bindings only after all imports are figured out
      dartBindings.forEach(dartFileStream.write);
      cBindings.forEach(cFileStream.write);
      await dartFileStream.close();
    }
    await cFileStream.close();
    stderr.writeln('Running dart format...');
    final formatRes =
        await Process.run('dart', ['format', dartWrappersRoot.toFilePath()]);
    if (formatRes.exitCode != 0) {
      stderr.writeln('ERROR: dart format completed with '
          'exit code ${formatRes.exitCode}');
    }

    stderr.writeln('Copying auxiliary files...');
    await _copyFileFromPackage(
        'jni', 'src/dartjni.h', cWrapperDir.resolve('dartjni.h'));
    await _copyFileFromPackage('jni_gen', 'cmake/CMakeLists.txt.tmpl',
        cWrapperDir.resolve('CMakeLists.txt'),
        transform: (s) => s.replaceAll('{{LIBRARY_NAME}}', libraryName));
    stderr.writeln('Completed.');
  }

  Future<void> _copyFileFromPackage(String package, String relPath, Uri target,
      {String Function(String)? transform}) async {
    final packagePath = await findPackageRoot(package);
    if (packagePath != null) {
      final sourceFile = File.fromUri(packagePath.resolve(relPath));
      final targetFile = await File.fromUri(target).create();
      var source = await sourceFile.readAsString();
      if (transform != null) {
        source = transform(source);
      }
      await targetFile.writeAsString(source);
    } else {
      stderr.writeln('package $package not found! '
          'skipped copying ${target.toFilePath()}');
    }
  }
}
