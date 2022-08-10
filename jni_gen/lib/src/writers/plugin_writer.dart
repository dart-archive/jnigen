import 'package:jni_gen/src/elements/elements.dart';
import 'package:jni_gen/src/config/wrapper_options.dart';

import 'bindings_writer.dart';

// TODO:

// Creates a plugin in directory pointed to by Url
// If a plugin already exists, then only updates the source files,
// leaving configuration such as pubspec.yaml intact
// Only the generated files are rewritten on subsequent runs, and even then
// any API exporter is not rewritten, allowing to add additional functionality
// in the same module.
class PluginOutput extends BindingsWriter {
  PluginOutput({
    required this.outputPath,
    required this.pluginName,
    this.pluginDomain = 'com.example',
    this.platforms = const ['android', 'linux', 'windows'],
  }) {
    throw UnimplementedError('Plugin writer not implemented.');
  }

  // Directory in which to create the plugin
  final Uri outputPath;

  final String pluginName;

  // late WrapperOptions _options;
  // late SymbolResolver _resolver;

  // Default: com.example
  // qualified name = $pluginDomain.$pluginName
  final String pluginDomain;

  final List<String> platforms;

  // additional YAML options to paste into new plugin's pubspec.
  final Map<String, dynamic> pubspecValues = const {};

  @override
  Future<void> writeBindings(
      Iterable<ClassDecl> classes, WrapperOptions options) async {}
}
