; Source: Adapted from https://github.com/tree-sitter-grammars/tree-sitter-pony/blob/master/queries/tags.scm
; Commit: 73ff874ae4c9e9b45462673cbc0a1e350e2522a7
; Last synced: 2025-12-21
; Note: Converted from tags.scm format to Zed's outline.scm format

; Class-like definitions
(class_definition
  "class" @context
  (identifier) @name) @item

(actor_definition
  "actor" @context
  (identifier) @name) @item

(primitive_definition
  "primitive" @context
  (identifier) @name) @item

(struct_definition
  "struct" @context
  (identifier) @name) @item

(type_alias
  "type" @context
  (identifier) @name) @item

; Interface-like definitions
(trait_definition
  "trait" @context
  (identifier) @name) @item

(interface_definition
  "interface" @context
  (identifier) @name) @item

; Method-like definitions
(constructor
  "new" @context
  (identifier) @name) @item

(method
  "fun" @context
  (identifier) @name) @item

(behavior
  "be" @context
  (identifier) @name) @item
