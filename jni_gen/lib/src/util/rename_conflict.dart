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
  'as',
  'async',
  'await',
  'const',
  'covariant',
  'deferred',
  'do',
  'dynamic',
  'export',
  'extension',
  'external',
  'factory',
  'Function',
  'get',
  'hide',
  'in',
  'is',
  'late',
  'library',
  'mixin',
  'on',
  'operator',
  'required',
  'rethrow',
  'set',
  'show',
  'sync',
  'typedef',
  'var',
  'with',
  'yield',
};
