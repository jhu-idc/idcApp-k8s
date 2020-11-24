package main

name = input.metadata.name

empty(value) {
  count(value) == 0
}

no_violations {
  empty(deny)
}

test_namespaces_not_denied {
  no_violations with input as { "kind": "Namespace", "metadata": { "name": "test" }}
}