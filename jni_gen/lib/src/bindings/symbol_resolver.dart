// A symbol resolver is useful mainly to convert a fully qualified name to
// a locally meaningful name, when creating dart bindings

import 'package:jni_gen/src/util/name_utils.dart';
import 'package:jni_gen/src/util/rename_conflict.dart';

abstract class SymbolResolver {
  /// Resolve the binary name to a String which can be used in dart code.
  String? resolve(String binaryName);
  List<String> getImportStrings();
  String kwPkgRename(String name, {Set<String> outer});
}

// TODO: resolve all included classes without requiring import mappings.

class PackagePathResolver implements SymbolResolver {
  PackagePathResolver(this.packages, this.currentPackage, this.inputs,
      {this.predefined = const {}});

  final String currentPackage;
  final Map<String, String> packages;
  final Map<String, String> predefined;
  final Set<String> inputs;

  final List<String> importStrings = [];

  final Map<String, String> _importedNameToPackage = {};
  final Map<String, String> _packageToImportedName = {};

  // return null if type's package cannot be resolved
  // else return the fully qualified name of type
  @override
  String? resolve(String binaryName) {
    if (predefined.containsKey(binaryName)) {
      return predefined[binaryName];
    }
    final parts = cutFromLast(binaryName, '.');
    final package = parts[0];
    final typename = parts[1];
    final simpleTypeName = typename.replaceAll('\$', '_');

    if (package == currentPackage && inputs.contains(binaryName)) {
      return simpleTypeName;
    }

    if (_packageToImportedName.containsKey(package)) {
      // This package was already resolved
      final importedName = _packageToImportedName[package];
      return '$importedName.$simpleTypeName';
    }

    final packageImport = getImport(package, binaryName);
    if (packageImport == null) {
      return null;
    }

    final pkgName = cutFromLast(package, '.')[1];
    if (pkgName.isEmpty) {
      throw UnsupportedError('No package could be deduced from '
          'qualified binaryName');
    }

    var importedName = pkgName;
    int suffix = 0;
    while (_importedNameToPackage.containsKey(importedName)) {
      suffix++;
      importedName = '$pkgName$suffix';
    }

    _importedNameToPackage[importedName] = package;
    _packageToImportedName[package] = importedName;
    importStrings.add('import "$packageImport" as $importedName;\n');
    return '$importedName.$simpleTypeName';
  }

  // returns import string, or null if package not found
  String? getImport(String packageToResolve, String binaryName) {
    final right = <String>[];
    var prefix = packageToResolve;
    if (prefix.isEmpty) {
      throw UnsupportedError('unexpected: empty package name.');
    }
    while (prefix.isNotEmpty) {
      final split = cutFromLast(prefix, '.');
      final left = split[0];
      right.add(split[1]);
      if (prefix == currentPackage && inputs.contains(binaryName)) {
        final sub = right.reversed.join('/');
        // relative import
        return '$sub.dart';
      }
      // eg: packages[org.apache.pdfbox]/org/apache/pdfbox.dart
      if (packages.containsKey(prefix)) {
        final sub = packageToResolve.replaceAll('.', '/');
        final pkg = _suffix(packages[prefix]!, '/');
        return '$pkg$sub.dart';
      }
      prefix = left;
    }
    return null;
  }

  String _suffix(String str, String suffix) {
    if (str.endsWith(suffix)) {
      return str;
    }
    return str + suffix;
  }

  @override
  List<String> getImportStrings() {
    return importStrings;
  }

  @override
  String kwPkgRename(String name, {Set<String> outer = const {}}) {
    final krn = kwRename(name);
    // sum members, package names map, outer
    if (_importedNameToPackage.containsKey(krn) || outer.contains(krn)) {
      return kwPkgRename('${krn}_', outer: outer);
    }
    return krn;
  }
}
