package.cpath = '../.libs/?.so'
local geos = require 'geos'

function table.deep_print(t1, indent)
	indent = indent or 0
	indent_string = string.rep(" ", indent)
	
	if t1 then
		for k, v in pairs(t1) do
			print(indent_string, k, v)
			if type(v) == "table" then
				table.deep_print(v, indent + 4)
			end
		end
	end
end

table.deep_print(geos, 4)

