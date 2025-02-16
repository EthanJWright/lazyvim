local M = {}

local function get_jest_config()
  -- Get configurations from the launch.json providers
  local configs = {}
  for _, provider in pairs(require("dap").providers.configs) do
    local conf = provider(vim.api.nvim_get_current_buf())
    if conf then
      vim.list_extend(configs, conf)
    end
  end

  -- Find the Jest configuration
  for _, conf in pairs(configs) do
    if conf.type == "node" and conf.name == "Debug Jest Tests" then
      return conf
    end
  end

  vim.notify("Could not find Jest debug configuration", vim.log.levels.ERROR)
  return nil
end

M.run_jest_debug_current_test = function()
  local get_current_test_name = require("custom.treesitter").get_current_test_name
  local test_name = get_current_test_name()
  if not test_name then
    vim.notify("No test found at cursor position", vim.log.levels.ERROR)
    return
  end

  local jest_config = get_jest_config()
  if not jest_config then
    return
  end

  -- Create a copy of the configuration and add test name filter
  local modified_conf = vim.deepcopy(jest_config)
  modified_conf.args = modified_conf.args or {}
  table.insert(modified_conf.args, "--testNamePattern")
  table.insert(modified_conf.args, test_name)

  vim.notify("Running test: " .. test_name, vim.log.levels.INFO)
  require("dap").run(modified_conf)
end

M.run_jest_debug = function()
  local dap = require("dap")

  -- If debugger is already running, just continue
  if dap.session() then
    dap.continue()
    return
  end

  -- Otherwise start a new debug session
  local jest_config = get_jest_config()
  if jest_config then
    dap.run(jest_config)
  end
end

return M
