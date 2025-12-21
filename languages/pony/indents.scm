; Source: https://github.com/tree-sitter-grammars/tree-sitter-pony/blob/master/queries/indents.scm
; Commit: 73ff874ae4c9e9b45462673cbc0a1e350e2522a7
; Last synced: 2025-12-21

[
  (use_statement)
  (actor_definition)
  (class_definition)
  (primitive_definition)
  (interface_definition)
  (trait_definition)
  (struct_definition)

  (constructor)
  (method)
  (behavior)

  (parameters)

  (if_block)
  (then_block)
  (elseif_block)
  (else_block)
  (iftype_statement)
  (elseiftype_block)
  (do_block)
  (match_statement)
  (parenthesized_expression)
  (tuple_expression)

  (array_literal)
  (object_literal)
] @indent

(try_statement (block) @indent)

(repeat_statement (block) @indent)

(recover_statement (block) @indent)

(return_statement (block) @indent)

(continue_statement (block) @indent)

(break_statement (block) @indent)

[
  "}"
  "]"
  ")"
] @indent_end

[ "{" "}" ] @branch

[ "[" "]" ] @branch

[ "(" ")" ] @branch

[
  (ERROR)
  (string)
  (line_comment)
  (block_comment)
] @auto
