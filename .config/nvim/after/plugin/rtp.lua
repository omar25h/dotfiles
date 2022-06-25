-- 
-- Extends the runtime path of Neovim to allow loading Lua workspace configurations.
-- Add ~/.nvim directory in the desired project to run.
-- The .nvim directory must be at the top level of the current git repository
--
-- TODO: If there is no git repository, check the current directory only.
--

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()

  if raw then
    return s
  end

  -- trim the output, removing newlines
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

local function has_extension(filename, extension)
  return filename:sub(-#extension) == extension
end

local function do_all(path)
  local scan = require('plenary.scandir')
  for _, file in ipairs(scan.scan_dir(path, { depth = 0 })) do
    if has_extension(file, '.lua') then
      dofile(file)
    end
  end
end

local function file_exists(name)
   local f = io.open(name, "r")
   return f ~= nil and io.close(f)
end

local function add_to_path(path)
  package.path = package.path .. ';' .. path
end

local command = 'git rev-parse --show-toplevel'
local output = os.capture(command)

if output ~= '' then
  local path = output .. '/.nvim'
  vim.opt.runtimepath:append(path)

  -- For some reason, Neovim does not update package.path automatically here
  add_to_path(path .. '/lua/?.lua')
  add_to_path(path .. '/lua/?/init.lua')
  add_to_path(path .. '/plugin/?.lua')
  add_to_path(path .. '/plugin/?/init.lua')
  add_to_path(path .. '/after/plugin/?.lua')
  add_to_path(path .. '/after/plugin/?/init.lua')

  -- Mimic plugin behavior
  if file_exists(path .. '/plugin') then
    do_all(path .. '/plugin/')
  end

  if file_exists(path .. '/after/plugin') then
    do_all(path .. '/after/plugin/')
  end

  if file_exists(path .. '/init.lua') then
    dofile(path .. '/init.lua')
  end
end

