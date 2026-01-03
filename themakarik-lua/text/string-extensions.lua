--[[
  Author: TheMakarik
  Under MIT
]]

---Validates search parameters for string operations
---@local
---@param str string The string to search in
---@param pattern string The pattern to search for
---@param caseSensitive boolean|nil  Whether search is case sensitive
local function validateSearchTypes(str, pattern, caseSensitive)
    assert(type(str) == "string", "search value must be string")
    assert(type(pattern) == "string", "search pattern must be string")
    assert(type(caseSensitive) == "nil" or type(caseSensitive) == "boolean", 
           "caseSensitive must be nil or boolean")
end

---Empty string constant
---@field empty ""
string.empty = ""

---Single space constant
---@field space " "
string.space = " "

---Checks if string starts with specified pattern
---@param pattern string Pattern to search for
---@param caseSensitive boolean|nil Whether to perform case-sensitive search (default: true)
---@return boolean True if string starts with pattern
---@usage ("Hello"):startswith("He") -- true
---@usage ("Hello"):startswith("he", false) -- true (case-insensitive)
---@usage ("Hello"):startswith("lo") -- false
function string:startswith(pattern, caseSensitive)
    validateSearchTypes(self, pattern, caseSensitive)
    
    if caseSensitive == false then
        local lowerSelf = self:lower()
        local lowerPattern = pattern:lower()
        return lowerSelf:sub(1, #lowerPattern) == lowerPattern
    end
    
    return self:sub(1, #pattern) == pattern
end

---Checks if string ends with specified pattern
---@param pattern string Pattern to search for
---@param caseSensitive boolean|nil Whether to perform case-sensitive search (default: true)
---@return boolean True if string ends with pattern
---@usage ("Hello"):endswith("lo") -- true
---@usage ("Hello"):endswith("LO", false) -- true (case-insensitive)
---@usage ("Hello"):endswith("He") -- false
function string:endswith(pattern, caseSensitive)
    validateSearchTypes(self, pattern, caseSensitive)
    
    if caseSensitive == false then
        local lowerSelf = self:lower()
        local lowerPattern = pattern:lower()
        return lowerSelf:sub(-#lowerPattern) == lowerPattern
    end
    
    return self:sub(-#pattern) == pattern
end

---Checks if string contains specified pattern
---@param pattern string Pattern to search for
---@param caseSensitive boolean|nil  Whether to perform case-sensitive search (default: true)
---@return boolean True if string contains pattern
---@usage ("Hello World"):contains("World") -- true
---@usage ("Hello World"):contains("world", false) -- true (case-insensitive)
---@usage ("Hello World"):contains("test") -- false
function string:contains(pattern, caseSensitive)
    validateSearchTypes(self, pattern, caseSensitive)
    
    if caseSensitive == false then
        local lowerSelf = self:lower()
        local lowerPattern = pattern:lower()
        return lowerSelf:find(lowerPattern, 1, true) ~= nil
    end
    
    return self:find(pattern, 1, true) ~= nil
end

---Checks if string does NOT contain specified pattern
---@param pattern string Pattern to search for
---@param caseSensitive boolean|nil  Whether to perform case-sensitive search (default: true)
---@return boolean True if string does NOT contain pattern
---@usage ("Hello"):notContains("test") -- true
---@usage ("Hello"):notContains("he", false) -- false (case-insensitive)
function string:notContains(pattern, caseSensitive)
    validateSearchTypes(self, pattern, caseSensitive)
    return not self:contains(pattern, caseSensitive)
end

---Checks if a value is null or empty string
---@param value any Value to check
---@return boolean True if value is nil or empty string
---@usage string.isNullOrEmpty("") -- true
---@usage string.isNullOrEmpty(nil) -- true
---@usage string.isNullOrEmpty("text") -- false
function string.isNullOrEmpty(value)
    return value == nil or value == string.empty
end

---Checks if a value is null, empty, or contains only whitespace
---@param value any Value to check
---@return boolean True if value is nil or whitespace-only string
---@usage string.isNullOrWhiteSpace("  ") -- true
---@usage string.isNullOrWhiteSpace(nil) -- true
---@usage string.isNullOrWhiteSpace("text") -- false
function string.isNullOrWhiteSpace(value)
    if value == nil then return true end
    if type(value) ~= "string" then return false end
    return value:match("^%s*$") ~= nil
end
  


---Gets character at specified index, indexes is one-based
---@param index number Character position (supports negative indexing from end)
---@return string|nil Character at index or nil if out of bounds
---@usage ("Hello"):elementAt(1) -- "H"
---@usage ("Hello"):elementAt(-1) -- "o"
---@usage ("Hello"):elementAt(10) -- nil
function string:elementAt(index)
    assert(type(index) == "number", "index must be number")
    
    if index < 0 then index = #self + index + 1 end
    if index < 1 or index > #self then
        return nil
    end
    
    return self:sub(index, index)
end

---Replaces all occurrences of oldValue with newValue
---@param oldValue string Value to replace
---@param newValue string Replacement value
---@param caseSensitive boolean|nil  Whether to perform case-sensitive replacement (default: true)
---@return string Modified string
---@usage ("Hello World"):replace("World", "Lua") -- "Hello Lua"
---@usage ("hello hello"):replace("HELLO", "Hi", false) -- "Hi Hi" (case-insensitive)
function string:replace(oldValue, newValue, caseSensitive)
    assert(type(oldValue) == "string", "oldValue must be string")
    assert(type(newValue) == "string", "newValue must be string")
    assert(type(caseSensitive) == "nil" or type(caseSensitive) == "boolean", 
           "caseSensitive must be nil or boolean")
    
    if caseSensitive == false then
        local result = self
        local lowerSelf = self:lower()
        local lowerOldValue = oldValue:lower()
        local startIndex = 1
        
        while true do
            local findStart, findEnd = lowerSelf:find(lowerOldValue, startIndex, true)
            if not findStart then break end
            
            local before = result:sub(1, findStart - 1)
            local after = result:sub(findEnd + 1)
            result = before .. newValue .. after
            
            lowerSelf = lowerSelf:sub(1, findStart - 1) .. string.rep(" ", #newValue) .. lowerSelf:sub(findEnd + 1)
            startIndex = findStart + #newValue
        end
        
        return result
    end
    
    local result = self:gsub(oldValue, newValue, -1, true)
    return result
end

---Compares string with another value for equality
---@param value any Value to compare
---@param caseSensitive boolean|nil  Whether to perform case-sensitive comparison (default: true)
---@return boolean True if values are equal
---@usage ("Hello"):equals("Hello") -- true
---@usage ("Hello"):equals("hello", false) -- true (case-insensitive)
---@usage ("Hello"):equals(123) -- false
function string:equals(value, caseSensitive)
    if type(value) ~= "string" then return false end
    assert(type(caseSensitive) == "nil" or type(caseSensitive) == "boolean", 
           "caseSensitive must be nil or boolean")
    
    if caseSensitive == false then
        return self:lower() == value:lower()
    end
    
    return self == value
end

---Compares string with another value for inequality
---@param value any Value to compare
---@param caseSensitive boolean|nil  Whether to perform case-sensitive comparison (default: true)
---@return boolean True if values are NOT equal
---@usage ("Hello"):notEquals("World") -- true
---@usage ("Hello"):notEquals("hello") -- true (case-sensitive)
---@usage ("Hello"):notEquals("hello", false) -- false (case-insensitive)
function string:notEquals(value, caseSensitive)
    return not self:equals(value, caseSensitive)
end

---Removes whitespace from both ends of string
---@return string Trimmed string
---@usage ("  Hello  "):trim() -- "Hello"
function string:trim()
    return self:match("^%s*(.-)%s*$")
end

---Removes whitespace from beginning of string
---@return string String with leading whitespace removed
---@usage ("  Hello  "):trimStart() -- "Hello  "
function string:trimStart()
    return self:match("^%s*(.+)$")
end

---Removes whitespace from end of string
---@return string String with trailing whitespace removed
---@usage ("  Hello  "):trimEnd() -- "  Hello"
function string:trimEnd()
    return self:match("^(.+%S)%s*$")
end

---Splits string into table using separator
---@param separator string|nil  Separator pattern (default: whitespace)
---@return table Table of substrings
---@usage ("a,b,c"):split(",") -- {"a","b","c"}
---@usage ("Hello World"):split() -- {"Hello","World"}
function string:split(separator)
    separator = separator or "%s"
    local result = {}
    local pattern = string.format("([^%s]+)", separator)
    
    for match in self:gmatch(pattern) do
        table.insert(result, match)
    end
    
    return result
end

---Converts string to table of individual characters
---@return table Table of characters
---@usage ("Hello"):toOneCharecterTable() -- {"H","e","l","l","o"}
function string:toOneCharecterTable()
    local chars = {}
    for i = 1, #self do
        chars[i] = self:sub(i, i)
    end
    return chars
end

---Checks if string is empty
---@return boolean True if string is empty
---@usage ("Hello"):isEmpty() -- false
---@usage (""):isEmpty() -- true
function string:isEmpty()
    return self == string.empty
end

---Checks if string contains only whitespace
---@return boolean True if string is whitespace-only
---@usage ("Hello"):isWhiteSpace() -- false
---@usage ("  \t\n "):isWhiteSpace() -- true
function string:isWhiteSpace()
    return self:match("^%s*$") ~= nil
end