-- Run shellcheck, parse into diagnostics.
local function run_shellcheck(args)
	local f = assert(io.popen('shellcheck --format=gcc --wiki-link-count=0 --color=never ' .. args.file))

	-- Build list of diagnostics.
	ds = {}
	while true do
		local l = f:read()
		if l == nil then
			break
		end

		-- Get line and column in finding.
		local _, _, ml, mc = string.find(l, '^[^:]+:([^:]+):([^:]+):')
		local line = tonumber(ml) - 1
		local col = tonumber(mc) - 1

		-- Get index of filename in finding.
		local i, j = string.find(l, '^[^:]+:')

		table.insert(ds, {
			lnum = line,
			col = col,
			message = string.sub(l, j + 1, -1), -- Do not display filename in diagnostic.
			source = 'shellcheck',
		})
	end

	vim.diagnostic.set(nid, 0, ds) -- 0 means current buffer.
	f:close()
end

nid = nil

-- Sets up buffer-local config and autocommands.
return function () 
	nid = vim.api.nvim_create_namespace('shellcheck-diagnostics')

	-- Run shellcheck after writing the file.
	local g = 'shellcheck-diagnostics'
	vim.api.nvim_create_augroup(g, { clear = true })
	vim.api.nvim_create_autocmd({'BufWritePost'}, {
		group = g,
		pattern = '<buffer>',
		callback = run_shellcheck
	})

	-- Run shellcheck on initial file load.
	run_shellcheck({ file = vim.fn.expand('%:p') })
end
