; Bracket matching for Pony using tree-sitter queries
;
; This file defines bracket pairs through syntax tree nodes rather than just
; character pairs. This provides more accurate bracket matching that understands
; the code structure.

; Parentheses - function calls, parameters, tuples, grouping
(parenthesized_expression "(" @open ")" @close)
(parameters "(" @open ")" @close)
(arguments "(" @open ")" @close)
(tuple_expression "(" @open ")" @close)
(lambda_parameters "(" @open ")" @close)

; Square brackets - arrays
(array_literal "[" @open "]" @close)

; Curly braces - lambda expressions
(lambda_expression "{" @open "}" @close)
(lambda_type "{" @open "}" @close)

; String literals - double quotes
(string "\"" @open "\"" @close)
