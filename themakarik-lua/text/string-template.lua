---@class StringTemplate respesent class for creating string templates with values inserting
StringTemplate = {}\

local stringTemplateMetatable = {}

function stringTemplateMetatable.__call(self, ...)
    local args = {...};
    return self.new((args[1]))
end

local stringTemplateInstanceMetatable = {}

---Creates a new instanse of StringTemplate
---@param template string StringTemplate
---@return StringTemplate StringTemplate instance
function StringTemplate.new(template)
    local template = {}
    
    return template
end

function StringTemplate:createString(...)
    
end