String renameConflict(Map<String, int> counts, String name) {
  name = kwRename(name);
  if (counts.containsKey(name)) {
    final count = counts[name]!;
    final renamed = '${name}_$count';
    counts[name] = count + 1;
    return renamed;
  }
  counts[name] = 1;
  return name;
}

String kwRename(String name) {
  if (_keywords.contains(name)) {
    return '${name}_';
  }
  return name;
}

// TODO: Add keywords(C) - keyword(Java)
// TODO: change C constructor naming from 'new' to something else?
const Set<String> _keywords = {
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covariant',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'Function',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'late',
  'library',
  'mixin',
  'new',
  'null',
  'on',
  'operator',
  'part',
  'required',
  'rethrow',
  'return',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  'while',
  'with',
  'yield',
};
