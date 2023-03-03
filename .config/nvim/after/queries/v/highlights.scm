; extends

(_
  (comment) @text.uri @_comment
  (function_declaration
    name: (identifier) @_b
  )
  (#offset! @_comment 0 3 0 -1)
  (#eq? @_comment @_b)
)

(raw_string_literal) @string
