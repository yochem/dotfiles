; extends

(variable_declaration
	"local" @matching.start
	(assignment_statement
		"=" @matching.end))

(function_declaration
	"local" @matching.start
	"function" @matching.middle
	"end" @matching.end)

(parameters
	.
	name: (identifier) @matching.start)

(parameters
	name: (identifier)
	name: (identifier) @matching.middle
	name: (identifier))

(parameters name: (identifier) @matching.end .)
