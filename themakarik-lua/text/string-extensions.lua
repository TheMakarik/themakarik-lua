--[[
  Author: TheMakarik
  Under MIT
]]

local function validateTypes(str, pattern, caseSensetive)
     assert(type(caseSensetive) == "nil" or type(caseSensetive) == "boolean", "caseSensetive must be nil or boolean")
end

function string:startswith(pattern, caseSensetive)
     validateTypes(self, pattern, caseSensetive)
end

function string:endswith(pattern, caseSensetive)
     validateTypes(self, pattern, caseSensetive)
end

function string:contains(pattern, caseSensetive)
     validateTypes(self, pattern, caseSensetive)
end

function string:notContains(pattern, caseSensetive)
     validateTypes(self, pattern, caseSensetive)
end

function string:isNullOrEmpty()

end

function string:isNullOrWhiteSpace()
  
end

function string:equals(value, caseSensetive)
    validateTypes(self, value, caseSensetive)
end