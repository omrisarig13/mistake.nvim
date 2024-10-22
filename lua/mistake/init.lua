local M = {}

M.setup = function(opts)
	local default_opts = {}

	local script_path = debug.getinfo(1).source:match("@?(.*[\\/])")
	default_opts.dict_file = script_path .. "dict.lua"

	default_opts.custom_dict_file = vim.fn.stdpath("config") .. "/mistake_custom_dict.lua"

	opts = opts or {}
	opts = vim.tbl_extend("force", default_opts, opts)

	if not vim.loop.fs_stat(opts.custom_dict_file) then
		local file = io.open(opts.custom_dict_file, "w")
		file:write('return {\n  ["teh"] = "the",\n}\n')
		file:close()
	end

	vim.api.nvim_create_user_command("MistakeEdit", function()
		vim.cmd("edit " .. opts.custom_dict_file)
	end, {})

	vim.defer_fn(function()
		M.load_abbreviations(opts.dict_file)
		M.load_abbreviations(opts.custom_dict_file)
	end, 0)
end

M.load_abbreviations = function(dict_file)
	local dict = loadfile(dict_file)()
	for typo, correction in pairs(dict) do
		vim.cmd(string.format("iabbrev %s %s", typo, correction))
	end
end

return M
