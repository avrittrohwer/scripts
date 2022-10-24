let &l:formatprg='shfmt -i ' . &l:shiftwidth . ' -sr -ci -s'
lua require('shellcheck-diagnostics')()
