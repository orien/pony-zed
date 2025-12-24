; Source: Adapted from https://github.com/tree-sitter-grammars/tree-sitter-pony/blob/master/queries/tags.scm
; Commit: 73ff874ae4c9e9b45462673cbc0a1e350e2522a7
; Last synced: 2025-12-21
;
; Adjustments made for Zed's outline.scm format:
; 1. Converted from tags.scm capture format (@definition.*) to Zed's outline format
;    - Changed @definition.class → @item with @context and @name captures
;    - Changed @definition.interface → @item with @context and @name captures
;    - Changed @definition.method → @item with @context and @name captures
; 2. Removed @reference.* captures (not needed for outline/structure view)
; 3. Added keyword literals (e.g., "class", "fun") as @context for display in outline
; 4. Simplified to focus on structural elements visible in outline panel:
;    - Type definitions (class, actor, primitive, struct, type)
;    - Interface definitions (trait, interface)
;    - Method definitions (new, fun, be)

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
