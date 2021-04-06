macro assert(exp, file = __FILE__, line = __LINE__)
	{% if !flag?(:release) %}
		unless {{exp}}
			raise "Assertion Failed #{{{file}}}:#{{{line}}}"
		end
	{% end %}
end
