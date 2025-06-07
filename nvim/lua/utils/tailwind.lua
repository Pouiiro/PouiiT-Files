local M = {}

local tailwind_config_files = {
  'tailwind.config.js',
  'tailwind.config.cjs',
  'tailwind.config.ts',
  'tailwind.config.mjs',
  'postcss.config.js',
  'postcss.config.ts',
  'postcss.config.mjs',
}

-- Check if Tailwind is in package.json dependencies or devDependencies
local function is_tailwind_in_package_json(root_dir)
  local pkg_path = root_dir .. '/package.json'
  local stat = vim.loop.fs_stat(pkg_path)
  if not stat then
    return false
  end

  local ok, json = pcall(vim.fn.json_decode, vim.fn.readfile(pkg_path))
  if not ok or type(json) ~= 'table' then
    return false
  end

  local deps = vim.tbl_extend('force', json.dependencies or {}, json.devDependencies or {})

  return deps['tailwindcss'] ~= nil
end

function M.has_tailwind(root_dir)
  root_dir = root_dir or vim.loop.cwd()

  for _, file in ipairs(tailwind_config_files) do
    if vim.fn.filereadable(root_dir .. '/' .. file) == 1 then
      return true
    end
  end

  return is_tailwind_in_package_json(root_dir)
end

return M
