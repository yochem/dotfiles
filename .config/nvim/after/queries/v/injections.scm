; extends

((call_expression
  function: (selector_expression
	  field: (identifier) @_re)
  arguments: (argument_list (raw_string_literal) @regex (#offset! @regex 0 2 0 -1)))
 (#any-of? @_re "regex_base" "regex_opt" "compile_opt")
)


(
 (comment) @_start (#eq? @_start "// ```v")
 (comment)+ @v (#offset! @v 0 3 0 )
 (comment) @_end (#eq? @_end "// ```")
)
