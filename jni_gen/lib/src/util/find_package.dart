import 'dart:io';

import 'package:package_config/package_config.dart';

Future<Uri?> findPackage(String packageName) async {
  final packageConfig = await findPackageConfig(Directory.current);
  if (packageConfig == null) {
    return null;
  }

  final packages = packageConfig.packages;
  for (var candidate in packages) {
    if (candidate.name == packageName) {
      return candidate.root;
    }
  }
  return null;
}

Future<Uri?> findPackageJni() => findPackage('jni');
