; Text objects for Pony using tree-sitter queries
;
; This file defines text objects for Vim mode navigation.
; Supported operations:
; - af/if: function text objects (around/inside)
; - ac/ic: class text objects (around/inside)
; - Motions: [m/]m (previous/next function), [[/]] (previous/next class)

; Functions - methods, behaviors, and constructors

(method) @function.around

(method
  (block) @function.inside
)

(behavior) @function.around

(behavior
  (block) @function.inside
)

(constructor) @function.around

(constructor
  (block) @function.inside
)

; Classes - actors, classes, primitives, interfaces, traits, structs

(actor_definition) @class.around

(actor_definition
  (members) @class.inside
)

(class_definition) @class.around

(class_definition
  (members) @class.inside
)

(primitive_definition) @class.around

(primitive_definition
  (members) @class.inside
)

(interface_definition) @class.around

(interface_definition
  (members) @class.inside
)

(trait_definition) @class.around

(trait_definition
  (members) @class.inside
)

(struct_definition) @class.around

(struct_definition
  (members) @class.inside
)

; Comments

(line_comment)+ @comment.around

(line_comment)+ @comment.inside

(block_comment) @comment.around

(block_comment) @comment.inside
