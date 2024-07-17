local function local_uuid()
  math.randomseed(os.clock())
  local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  return (
    string.gsub(template, "[xy]", function(c)
      local v = (c == "x") and math.random(0, 0xf) or math.random(8, 0xb)
      return string.format("%x", v)
    end)
  )
end

local is_guid = "%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x"
local has_std = true

-- Use standard lib, if unavailable use local env
local function uuid()
  if has_std then
    local id, _ = vim.fn.system("uuidgenn"):gsub("\n", "")
    if id:match(is_guid) then
      return id
    end
  end
  has_std = false
  return local_uuid()
end

return uuid
