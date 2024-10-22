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

	local function load_chunked_entries(dict_file, entries_per_chunk)
		local dict = loadfile(dict_file)()
		local entries = {}
		for typo, correction in pairs(dict) do
			table.insert(entries, { typo, correction })
		end

		local index = 1
		local initial_delay = 50
		local last_duration = initial_delay

		local function load_next_chunk()
			local start_time = vim.loop.hrtime()
			local limit = math.min(index + entries_per_chunk - 1, #entries)
			for i = index, limit do
				vim.cmd(string.format("iabbrev %s %s", entries[i][1], entries[i][2]))
			end
			local end_time = vim.loop.hrtime()
			last_duration = (end_time - start_time) / 1e6

			local new_delay = math.floor(last_duration * 2)

			index = limit + 1
			if index <= #entries then
				vim.defer_fn(load_next_chunk, new_delay)
			end
		end

		load_next_chunk()
	end

	load_chunked_entries(opts.dict_file, 100)
	load_chunked_entries(opts.custom_dict_file, 100)
end

return M
