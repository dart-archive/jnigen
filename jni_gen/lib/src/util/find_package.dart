import 'dart:io';

import 'package:package_config/package_config.dart';

Future<Uri?> findPackage(String packageName) async {
  final packageConfig = await findPackageConfig(Directory.current);
  if (packageConfig == null) {
    return null;
  }

  return packageConfig[packageName]?.root;
}

Future<Uri?> findPackageJni() => findPackage('jni');
