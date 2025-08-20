local lush = require('lush')

local hsl = lush.hsl

local black = hsl(0, 0, 0)
local white = hsl(0, 0, 100)
local darkgrey = hsl(0, 0, 35)
local lightgrey = hsl(0, 0, 95)

local red = hsl(0, 100, 50)
local yellow = hsl(60, 100, 50)
local darkyellow = hsl(60, 100, 40)
local green = hsl(120, 100, 50)
local cyan = hsl(180, 100, 50)
local darkcyan = hsl(180, 100, 40)
local lightcyan = hsl(180, 100, 90)
local blue = hsl(240, 100, 50)
local lightblue = hsl(240, 100, 91)
local magenta = hsl(300, 100, 50)

---@diagnostic disable: undefined-global
return lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    Normal         { fg=darkgrey, bg=white }, -- Normal text
    NormalFloat    { Normal }, -- Normal text in floating windows.
    FloatBorder    { Normal }, -- Border of floating windows.

    CursorColumn   { bg=lightgrey }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine     { gui='underline' }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.

    StatusLine     { fg=white, bg=black }, -- Status line of current window
    StatusLineNC   { bg=lightblue }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.

    Visual         { bg=lightcyan, fg=black }, -- Visual mode selection
    MatchParen     { bg=green }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    Whitespace     { bg=yellow }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WarningMsg     { fg=darkyellow }, -- Warning messages
    ErrorMsg       { fg=red }, -- Error messages on the command line

    Search         { bg=yellow }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    IncSearch      { Search }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    CurSearch      { bg=darkyellow }, -- Highlighting a search pattern under the cursor (see 'hlsearch')

    DiffAdd        { bg=green }, -- Diff mode: Added line |diff.txt|
    DiffChange     { bg=lightgrey }, -- Diff mode: Changed line |diff.txt|
    DiffDelete     { bg=red, fg=white }, -- Diff mode: Deleted line |diff.txt|
    DiffText       { bg=magenta, fg=white }, -- Diff mode: Changed text within a changed line |diff.txt|

    Ignore         { Normal }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error          { bg=red, fg=white }, -- Any erroneous construct
    Todo           { bg=yellow }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    Comment        { fg=black }, -- Any comment

    Constant       { fg=blue }, -- (*) Any constant
    String         { Constant }, --   A string constant: "this is a string"
    Character      { Constant }, --   A character constant: 'c', '\n'
    Number         { Constant }, --   A number constant: 234, 0xff
    Boolean        { Constant }, --   A boolean constant: TRUE, false
    Float          { Constant }, --   A floating point constant: 2.3e10

    Identifier     { Normal }, -- (*) Any variable name
    Function       { Normal }, --   Function name (also: methods for classes)

    Statement      { fg=black, gui = 'bold' }, -- (*) Any statement
    Conditional    { Statement }, --   if, then, else, endif, switch, etc.
    Repeat         { Statement }, --   for, do, while, etc.
    Label          { Statement }, --   case, default, etc.
    Operator       { Statement }, --   "sizeof", "+", "*", etc.
    Keyword        { Statement }, --   any other keyword
    Exception      { Statement }, --   try, catch, throw
    PreProc        { Statement }, -- (*) Generic Preprocessor
    Include        { Statement }, --   Preprocessor #include
    Define         { Statement }, --   Preprocessor #define
    Macro          { Statement }, --   Same as Define
    PreCondit      { Statement }, --   Preprocessor #if, #else, #endif, etc.
    Type           { Statement }, -- (*) int, long, char, etc.
    StorageClass   { Statement }, --   static, register, volatile, etc.
    Structure      { Statement }, --   struct, union, enum, etc.
    Typedef        { Statement }, --   A typedef

    Underlined     { gui = 'underline' }, -- Text that stands out, HTML links
    Tag            { Underlined }, --   You can use CTRL-] on this
    Special        { Normal }, -- (*) Any special symbol
    SpecialChar    { Normal }, --   Special character in a constant
    Delimiter      { Normal }, --   Character that needs attention
    SpecialComment { Normal }, --   Special things inside a comment (e.g. '\n')
    Debug          { Normal }, --   Debugging statements

    -- Tree-Sitter syntax groups.
    sym"@text.todo"         { Todo }, -- Todo
    sym"@debug"             { Normal }, -- Debug
    sym"@tag"               { Normal, gui='underline' }, -- Tag
    sym"@text.literal"      { Normal }, -- Comment
    sym"@text.reference"    { Normal }, -- Identifier
    sym"@text.title"        { Normal }, -- Title
    sym"@text.uri"          { Normal }, -- Underlined
    sym"@text.underline"    { Normal, gui='underline' }, -- Underlined

    sym"@comment"           { Comment }, -- Comment

    sym"@punctuation"       { Normal }, -- Delimiter
    sym"@variable"          { Normal }, -- Identifier
    sym"@namespace"         { Normal }, -- Identifier
    sym"@function"          { Normal }, -- Function
    sym"@function.builtin"  { Normal }, -- Special
    sym"@function.macro"    { Normal }, -- Macro
    sym"@parameter"         { Normal }, -- Identifier
    sym"@method"            { Normal }, -- Function
    sym"@field"             { Normal }, -- Identifier
    sym"@property"          { Normal }, -- Identifier
    sym"@constructor"       { Normal }, -- Special

    sym"@constant"          { Constant }, -- Constant
    sym"@constant.builtin"  { Constant }, -- Special
    sym"@constant.macro"    { Constant }, -- Define
    sym"@string"            { Constant }, -- String
    sym"@string.escape"     { Constant }, -- SpecialChar
    sym"@string.special"    { Constant }, -- SpecialChar
    sym"@character"         { Constant }, -- Character
    sym"@character.special" { Constant }, -- SpecialChar
    sym"@number"            { Constant }, -- Number
    sym"@boolean"           { Constant }, -- Boolean
    sym"@float"             { Constant }, -- Float

    sym"@define"            { Statement }, -- Define
    sym"@macro"             { Statement }, -- Macro
    sym"@conditional"       { Statement }, -- Conditional
    sym"@repeat"            { Statement }, -- Repeat
    sym"@label"             { Statement }, -- Label
    sym"@operator"          { Statement }, -- Operator
    sym"@keyword"           { Statement }, -- Keyword
    sym"@exception"         { Statement }, -- Exception
    sym"@type"              { Statement }, -- Type
    sym"@type.definition"   { Statement }, -- Typedef
    sym"@storageclass"      { Statement }, -- StorageClass
    sym"@structure"         { Statement }, -- Structure
    sym"@include"           { Statement }, -- Include
    sym"@preproc"           { Statement }, -- PreProc

    ---- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    DiagnosticError            { fg=red } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn             { fg=darkyellow } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo             { Normal } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint             { fg=darkcyan } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticOk               { Normal } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticUnderlineError   { gui='undercurl' } , -- Used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn    { DiagnosticUnderlineError } , -- Used to underline "Warn" diagnostics.
    DiagnosticUnderlineInfo    { DiagnosticUnderlineError } , -- Used to underline "Info" diagnostics.
    DiagnosticUnderlineHint    { DiagnosticUnderlineError } , -- Used to underline "Hint" diagnostics.
    DiagnosticUnderlineOk      { DiagnosticUnderlineError } , -- Used to underline "Ok" diagnostics.


    -- Other elements available for styling
    --ColorColumn    { }, -- Columns set with 'colorcolumn'
    --Conceal        { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    --Cursor         { }, -- Character under the cursor
    --lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    --CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
    --Directory      { }, -- Directory names (and other special names in listings)
    --EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    --TermCursor     { }, -- Cursor in a focused terminal
    --TermCursorNC   { }, -- Cursor in an unfocused terminal
    --VertSplit      { }, -- Column separating vertically split windows
    --Folded         { }, -- Line used for closed folds
    --FoldColumn     { }, -- 'foldcolumn'
    --SignColumn     { }, -- Column where |signs| are displayed
    --Substitute     { }, -- |:substitute| replacement text highlighting
    --LineNr         { }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    --LineNrAbove    { }, -- Line number for when the 'relativenumber' option is set, above the cursor line
    --LineNrBelow    { }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    --CursorLineNr   { }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    --CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    --CursorLineSign { }, -- Like SignColumn when 'cursorline' is set for the cursor line
    --ModeMsg        { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    --MsgArea        { }, -- Area for messages and cmdline
    --MsgSeparator   { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    --MoreMsg        { }, -- |more-prompt|
    --NonText        { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    --FloatTitle     { }, -- Title of floating windows.
    --NormalNC       { }, -- normal text in non-current windows
    --Pmenu          { }, -- Popup menu: Normal item.
    --PmenuSel       { }, -- Popup menu: Selected item.
    --PmenuKind      { }, -- Popup menu: Normal item "kind"
    --PmenuKindSel   { }, -- Popup menu: Selected item "kind"
    --PmenuExtra     { }, -- Popup menu: Normal item "extra text"
    --PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
    --PmenuSbar      { }, -- Popup menu: Scrollbar.
    --PmenuThumb     { }, -- Popup menu: Thumb of the scrollbar.
    --Question       { }, -- |hit-enter| prompt and yes/no questions
    --QuickFixLine   { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    --SpecialKey     { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    --SpellBad       { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    --SpellCap       { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    --SpellLocal     { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    --SpellRare      { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    --TabLine        { }, -- Tab pages line, not active tab page label
    --TabLineFill    { }, -- Tab pages line, where there are no labels
    --TabLineSel     { }, -- Tab pages line, active tab page label
    --Title          { }, -- Titles for output from ":set all", ":autocmd" etc.
    --Winseparator   { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    --WildMenu       { }, -- Current match in 'wildmenu' completion
    --WinBar         { }, -- Window bar of current window
    --WinBarNC       { }, -- Window bar of not-current windows
    --DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    --DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    --DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    --DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    --DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
    --DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    --DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    --DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    --DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    --DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
    --DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    --DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    --DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    --DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
    --DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.


    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.
    --LspReferenceText            { } , -- Used for highlighting "text" references
    --LspReferenceRead            { } , -- Used for highlighting "read" references
    --LspReferenceWrite           { } , -- Used for highlighting "write" references
    --LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    --LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    --LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.
  }
end)
