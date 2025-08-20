vim.opt_local.spell = true
vim.opt_local.formatoptions = 'tcroqan1p' -- autoformat text and comments
vim.opt_local.comments = ':>' -- format GitHub alerts sections as comments

vim.opt_local.statusline = ("%{stridx(&l:formatoptions, 'a') == -1 ? 'autoformat: disabled' : 'autoformat: enabled'} %{FugitiveStatusline()} %<%f %h%w%m%r %=%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}")
