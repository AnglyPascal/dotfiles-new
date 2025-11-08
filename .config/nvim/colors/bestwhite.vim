" Name:         Best White
" Description:  A light companion to bestblack theme
" Author:       Based on Xcode Light High Contrast
" License:      Vim License (see `:help license`)

set background=light

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'bestwhite'

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#b4d8fd', '#ad1805', '#355d61', '#78492a',
        \ '#0058a1', '#9c2191', '#703daa', '#000000', '#8a99a6', '#ad1805',
        \ '#174145', '#78492a', '#003f73', '#9c2191', '#441ea1', '#000000']
  if has('nvim')
    let g:terminal_color_0 = '#b4d8fd'
    let g:terminal_color_1 = '#ad1805'
    let g:terminal_color_2 = '#355d61'
    let g:terminal_color_3 = '#78492a'
    let g:terminal_color_4 = '#0058a1'
    let g:terminal_color_5 = '#9c2191'
    let g:terminal_color_6 = '#703daa'
    let g:terminal_color_7 = '#000000'
    let g:terminal_color_8 = '#8a99a6'
    let g:terminal_color_9 = '#ad1805'
    let g:terminal_color_10 = '#174145'
    let g:terminal_color_11 = '#78492a'
    let g:terminal_color_12 = '#003f73'
    let g:terminal_color_13 = '#9c2191'
    let g:terminal_color_14 = '#441ea1'
    let g:terminal_color_15 = '#000000'
  endif
  
  if !exists('g:bestwhite_green_comments')
    let g:bestwhite_green_comments = 0
  endif
  if !exists('g:bestwhite_emph_types')
    let g:bestwhite_emph_types = 1
  endif
  if !exists('g:bestwhite_emph_funcs')
    let g:bestwhite_emph_funcs = 0
  endif
  if !exists('g:bestwhite_emph_idents')
    let g:bestwhite_emph_idents = 0
  endif
  if !exists('g:bestwhite_match_paren_style')
    let g:bestwhite_match_paren_style = 0
  endif
  if !exists('g:bestwhite_dim_punctuation')
    let g:bestwhite_dim_punctuation = 1
  endif

  hi Normal         guifg=#000000 guibg=#ffffff guisp=NONE gui=NONE      cterm=NONE
  hi None           guifg=#000000 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi CursorLineNr   guifg=#000000 guibg=#ecf5ff guisp=NONE gui=NONE      cterm=NONE
  hi MatchWord      guifg=#ffffff guibg=#156adf guisp=NONE gui=NONE      cterm=NONE
  hi Pmenu          guifg=#000000 guibg=#f4f4f4 guisp=NONE gui=NONE      cterm=NONE
  hi PmenuSel       guifg=#ffffff guibg=#156adf guisp=NONE gui=NONE      cterm=NONE
  hi QuickFixLine   guifg=#ffffff guibg=#156adf guisp=NONE gui=NONE      cterm=NONE
  hi StatusLine     guifg=#000000 guibg=#e5e5e5 guisp=NONE gui=NONE      cterm=NONE
  hi WildMenu       guifg=#ffffff guibg=#156adf guisp=NONE gui=NONE      cterm=NONE
  hi Search         guifg=#000000 guibg=#e5e5e5 guisp=NONE gui=NONE      cterm=NONE
  hi FoldColumn     guifg=#cdcdcd guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi Folded         guifg=#8a99a6 guibg=#f4f4f4 guisp=NONE gui=NONE      cterm=NONE
  hi LineNr         guifg=#aeb7c0 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi SignColumn     guifg=#cdcdcd guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi Ignore         guifg=#cdcdcd guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi PmenuThumb     guifg=#e5e5e5 guibg=#e5e5e5 guisp=NONE gui=NONE      cterm=NONE
  hi PmenuSbar      guifg=#f4f4f4 guibg=#f4f4f4 guisp=NONE gui=NONE      cterm=NONE
  hi EndOfBuffer    guifg=#ffffff guibg=#ffffff guisp=NONE gui=NONE      cterm=NONE
  hi Cursor         guifg=#ffffff guibg=#17171c guisp=NONE gui=NONE      cterm=NONE
  hi Signify        guifg=#69a7fc guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi ErrorMsg       guifg=#ad1805 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi ModeMsg        guifg=#8a99a6 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi MoreMsg        guifg=#9c2191 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi Question       guifg=#9c2191 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi WarningMsg     guifg=#78492a guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi ALEWarningSign guifg=#78492a guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi ColorColumn    guifg=NONE    guibg=#f4f4f4 guisp=NONE gui=NONE      cterm=NONE
  hi CursorColumn   guifg=NONE    guibg=#ecf5ff guisp=NONE gui=NONE      cterm=NONE
  hi CursorLine     guifg=NONE    guibg=#ecf5ff guisp=NONE gui=NONE      cterm=NONE
  hi StatusLineNC   guifg=#8a99a6 guibg=#f4f4f4 guisp=NONE gui=NONE      cterm=NONE
  hi VertSplit      guifg=#f4f4f4 guibg=#f4f4f4 guisp=NONE gui=NONE      cterm=NONE
  hi IncSearch      guifg=#000000 guibg=#fef869 guisp=NONE gui=NONE      cterm=NONE
  hi Visual         guifg=NONE    guibg=#b4d8fd guisp=NONE gui=NONE      cterm=NONE

  hi DiffAdd        guifg=NONE    guibg=#edfff0 guisp=NONE gui=NONE      cterm=NONE
  hi DiffChange     guifg=NONE    guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi DiffDelete     guifg=NONE    guibg=#fef0f1 guisp=NONE gui=NONE      cterm=NONE
  hi DiffText       guifg=NONE    guibg=#fdfae6 guisp=NONE gui=NONE      cterm=NONE

  hi GitGutterAdd    guifg=#2d8504 guibg=#edfff0
  hi GitGutterChange guifg=#78492a guibg=#fdfae6
  hi GitGutterDelete guifg=#ad1805 guibg=#fef0f1

  hi Comment        guifg=#8a99a6 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi Error          guifg=#ffffff guibg=#ad1805 guisp=NONE gui=NONE      cterm=NONE
  hi PreProc        guifg=#78492a guibg=NONE    guisp=NONE gui=BOLD      cterm=BOLD
  hi PreProcNoBold  guifg=#78492a guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi Special        guifg=#174145 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi Statement      guifg=#9c2191 guibg=NONE    guisp=NONE gui=bold      cterm=bold
  hi Character      guifg=#272ad8 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi Directory      guifg=#0058a1 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi Number         guifg=#272ad8 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi SpecialComment guifg=#5c6873 guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi String         guifg=#0f5bca guibg=NONE    guisp=NONE gui=NONE      cterm=NONE
  hi Title          guifg=#000000 guibg=NONE    guisp=NONE gui=bold      cterm=bold
  hi Todo           guifg=#5c6873 guibg=NONE    guisp=NONE gui=bold      cterm=bold
  hi Underlined     guifg=#0058a1 guibg=NONE    guisp=NONE gui=underline cterm=underline
  hi SpellBad       guifg=NONE    guibg=NONE    guisp=NONE gui=undercurl cterm=underline ctermfg=NONE ctermbg=NONE  
  hi SpellCap       guifg=NONE    guibg=NONE    guisp=NONE gui=undercurl cterm=undercurl ctermfg=NONE ctermbg=NONE  
  hi SpellLocal     guifg=NONE    guibg=NONE    guisp=NONE gui=undercurl cterm=undercurl ctermfg=NONE ctermbg=NONE  
  hi SpellRare      guifg=NONE    guibg=NONE    guisp=NONE gui=undercurl cterm=undercurl ctermfg=NONE ctermbg=NONE  

  let g:indentLine_color_gui  = '#cdcdcd'
  let g:indentLine_color_term = 252
  let g:limelight_conceal_guifg = '#8a99a6'
  let g:limelight_conceal_ctermfg = 246
  
  hi! link Terminal Normal
  hi! link pythonSpaceError Normal
  hi! link TabLine StatusLineNC
  hi! link TabLineFill StatusLineNC
  hi! link TabLineSel StatusLine
  hi! link StatusLineTerm StatusLine
  hi! link StatusLineTermNC StatusLineNC
  hi! link VisualNOS Visual
  hi! link MsgArea Title
  hi! link diffAdded DiffAdd
  hi! link diffBDiffer WarningMsg
  hi! link diffChanged DiffChange
  hi! link diffCommon WarningMsg
  hi! link diffDiffer WarningMsg
  hi! link diffFile Directory
  hi! link diffIdentical WarningMsg
  hi! link diffIndexLine Number
  hi! link diffIsA WarningMsg
  hi! link diffNoEOL WarningMsg
  hi! link diffOnly WarningMsg
  hi! link diffRemoved DiffDelete
  hi! link Constant LibraryIdent
  hi! link Float Number
  hi! link StringDelimiter String
  hi! link Identifier LocalIdent
  hi! link Function LibraryFunc
  hi! link FunctionRegular LibraryFuncRegular
  hi! link Boolean Statement
  hi! link Conditional Statement
  hi! link Exception Statement
  hi! link Include Statement
  hi! link Keyword Statement
  hi! link Label Statement
  hi! link Repeat Statement
  hi! link StorageClass Statement
  hi! link Structure Statement
  hi! link Define PreProc
  hi! link Macro PreProc
  hi! link PreCondit PreProc
  hi! link Type LibraryType
  hi! link Debug Special
  hi! link SpecialChar Special
  hi! link Tag Special
  hi! link Noise Delimiter
  hi! link Quote StringDelimiter
  hi! link Conceal Ignore
  hi! link NonText Ignore
  hi! link SpecialKey Ignore
  hi! link Whitespace Ignore
  hi! link Searchlight IncSearch
  hi! link SignifySignAdd Signify
  hi! link SignifySignChange Signify
  hi! link SignifySignDelete Signify
  hi! link bibEntryKw LibraryIdent
  hi! link bibKey IdentifierDef
  hi! link bibType LibraryType
  hi! link cssAtRule Keyword
  hi! link cssAttr Keyword
  hi! link cssBraces cssNoise
  hi! link cssClassName LocalIdent
  hi! link cssColor cssAttr
  hi! link cssFunction None
  hi! link cssIdentifier LocalIdent
  hi! link cssProp LibraryType
  hi! link cssPseudoClassId LibraryIdent
  hi! link cssSelectorOp Operator
  hi! link gitcommitHeader Todo
  hi! link gitcommitOverflow Error
  hi! link gitcommitSummary Title
  hi! link goField LocalIdent
  hi! link goFunction FunctionDef
  hi! link goFunctionCall LibraryFunc
  hi! link goVarAssign LocalIdent
  hi! link goVarDefs IdentifierDef
  hi! link helpCommand helpExample
  hi! link helpExample markdownCode
  hi! link helpHeadline Title
  hi! link helpHyperTextEntry Comment
  hi! link helpHyperTextJump Underlined
  hi! link helpSectionDelim Ignore
  hi! link helpURL helpHyperTextJump
  hi! link helpVim Title
  hi! link htmlArg Special
  hi! link htmlEndTag Delimiter
  hi! link htmlLink Underlined
  hi! link htmlSpecialTagName htmlTagName
  hi! link htmlTag Delimiter
  hi! link htmlTagName Statement
  hi! link jinjaBlockName Typedef
  hi! link jinjaFilter LibraryFunc
  hi! link jinjaNumber Number
  hi! link jinjaOperator Operator
  hi! link jinjaRawDelim PreProc
  hi! link jinjaSpecial Keyword
  hi! link jinjaString String
  hi! link jinjaTagDelim Delimiter
  hi! link jinjaVarDelim Delimiter
  hi! link jsBuiltins LibraryFunc
  hi! link jsClassDefinition Typedef
  hi! link jsDomErrNo LibraryIdent
  hi! link jsDomNodeConsts LibraryIdent
  hi! link jsExceptions LibraryType
  hi! link jsFuncArgCommas jsNoise
  hi! link jsFuncName FunctionDef
  hi! link jsFunction jsStatement
  hi! link jsGlobalNodeObjects jsGlobalObjects
  hi! link jsGlobalObjects LibraryType
  hi! link jsObjectProp LocalIdent
  hi! link jsOperatorKeyword jsStatement
  hi! link jsThis jsStatement
  hi! link jsVariableDef IdentifierDef
  hi! link jsonKeyword jsonString
  hi! link jsonKeywordMatch Operator
  hi! link jsonQuote StringDelimiter
  hi! link rsForeignConst LibraryIdent
  hi! link rsForeignFunc LibraryFunc
  hi! link rsForeignType LibraryType
  hi! link rsFuncDef FunctionDef
  hi! link rsIdentDef IdentifierDef
  hi! link rsLibraryConst LibraryIdent
  hi! link rsLibraryFunc LibraryFunc
  hi! link rsLibraryType LibraryType
  hi! link rsLifetimeDef IdentifierDef
  hi! link rsSpecialLifetime LibraryIdent
  hi! link rsUserConst LocalIdent
  hi! link rsUserFunc LocalFunc
  hi! link rsUserLifetime LocalIdent
  hi! link rsUserMethod LibraryFunc
  hi! link rsUserType LocalType
  hi! link scssAttribute cssNoise
  hi! link scssInclude Keyword
  hi! link scssMixin Keyword
  hi! link scssMixinName LocalFunc
  hi! link scssMixinParams cssNoise
  hi! link scssSelectorName cssClassName
  hi! link scssVariableAssignment Operator
  hi! link scssVariableValue Operator
  hi! link swiftFuncDef FunctionDef
  hi! link swiftIdentDef IdentifierDef
  hi! link swiftLibraryFunc LibraryFunc
  hi! link swiftLibraryProp LibraryIdent
  hi! link swiftLibraryType LibraryType
  hi! link swiftUserFunc LocalFunc
  hi! link swiftUserProp LocalIdent
  hi! link swiftUserType LocalType
  hi! link typescriptArrayMethod LibraryFunc
  hi! link typescriptArrowFunc Operator
  hi! link typescriptAssign Operator
  hi! link typescriptBOM LibraryType
  hi! link typescriptBOMWindowCons LibraryType
  hi! link typescriptBOMWindowMethod LibraryFunc
  hi! link typescriptBOMWindowProp LibraryType
  hi! link typescriptBinaryOp Operator
  hi! link typescriptBraces Delimiter
  hi! link typescriptCall None
  hi! link typescriptClassHeritage Type
  hi! link typescriptClassName TypeDef
  hi! link typescriptDOMDocMethod LibraryFunc
  hi! link typescriptDOMDocProp LibraryIdent
  hi! link typescriptDOMEventCons LibraryType
  hi! link typescriptDOMEventMethod LibraryFunc
  hi! link typescriptDOMEventMethod LibraryFunc
  hi! link typescriptDOMEventProp LibraryIdent
  hi! link typescriptDOMEventTargetMethod LibraryFunc
  hi! link typescriptDOMNodeMethod LibraryFunc
  hi! link typescriptDOMStorageMethod LibraryIdent
  hi! link typescriptEndColons Delimiter
  hi! link typescriptExport Keyword
  hi! link typescriptFuncName FunctionDef
  hi! link typescriptFuncTypeArrow typescriptArrowFunc
  hi! link typescriptGlobal typescriptPredefinedType
  hi! link typescriptIdentifier Keyword
  hi! link typescriptInterfaceName Typedef
  hi! link typescriptMember LocalFunc
  hi! link typescriptObjectLabel LocalIdent
  hi! link typescriptOperator Keyword
  hi! link typescriptParens Delimiter
  hi! link typescriptPredefinedType LibraryType
  hi! link typescriptTypeAnnotation Delimiter
  hi! link typescriptTypeReference typescriptUserDefinedType
  hi! link typescriptUserDefinedType LocalType
  hi! link typescriptVariable Keyword
  hi! link typescriptVariableDeclaration IdentifierDef
  hi! link vimAutoCmdSfxList LibraryType
  hi! link vimAutoEventList LocalIdent
  hi! link vimCmdSep Special
  hi! link vimCommentTitle SpecialComment
  hi! link vimContinue Delimiter
  hi! link vimFuncName LibraryFunc
  hi! link vimFunction FunctionDef
  hi! link vimHighlight Statement
  hi! link vimMapModKey vimNotation
  hi! link vimNotation LibraryType
  hi! link vimOption LibraryIdent
  hi! link vimUserFunc LocalFunc
  hi! link markdownBoldDelimiter markdownDelimiter
  hi! link markdownBoldItalicDelimiter markdownDelimiter
  hi! link markdownCodeBlock markdownCode
  hi! link markdownCodeDelimiter markdownDelimiter
  hi! link markdownHeadingDelimiter markdownDelimiter
  hi! link markdownItalicDelimiter markdownDelimiter
  hi! link markdownLinkDelimiter markdownDelimiter
  hi! link markdownLinkText None
  hi! link markdownLinkTextDelimiter markdownDelimiter
  hi! link markdownListMarker markdownDelimiter
  hi! link markdownRule markdownDelimiter
  hi! link markdownUrl Underlined

  hi markdownDelimiter guifg=#355d61 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi markdownCode guifg=#703daa guibg=#f4f4f4 guisp=NONE gui=NONE cterm=NONE
  
  if g:bestwhite_green_comments
    hi Comment guifg=#1f6300 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi SpecialComment guifg=#1f6300 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Todo guifg=#1f6300 guibg=NONE guisp=NONE gui=bold cterm=bold
  endif
  
  if g:bestwhite_emph_types
    hi Typedef guifg=#003f73 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LocalType guifg=#174145 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LibraryType guifg=#441ea1 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  else
    hi Typedef guifg=#0058a1 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LocalType guifg=#355d61 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LibraryType guifg=#703daa guibg=NONE guisp=NONE gui=NONE cterm=NONE
  endif
  
  if g:bestwhite_emph_funcs
    hi FunctionDef guifg=#003f73 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LocalFunc guifg=#174145 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LibraryFunc guifg=#441ea1 guibg=NONE guisp=NONE gui=bold cterm=bold
    hi LibraryFuncRegular guifg=#441ea1 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  else
    hi FunctionDef guifg=#0058a1 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LocalFunc guifg=#355d61 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LibraryFunc guifg=#703daa guibg=NONE guisp=NONE gui=bold cterm=bold
    hi LibraryFuncRegular guifg=#703daa guibg=NONE guisp=NONE gui=NONE cterm=NONE
  endif
  
  if g:bestwhite_emph_idents
    hi IdentifierDef guifg=#003f73 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LocalIdent guifg=#174145 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LibraryIdent guifg=#441ea1 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  else
    hi IdentifierDef guifg=#0058a1 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LocalIdent guifg=#355d61 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi LibraryIdent guifg=#703daa guibg=NONE guisp=NONE gui=NONE cterm=NONE
  endif
  
  if g:bestwhite_match_paren_style
    hi MatchParen guifg=#17171c guibg=#ebcb8b guisp=NONE gui=NONE cterm=NONE
  else
    hi MatchParen guifg=#17171c guibg=#88c0d0 guisp=NONE gui=bold cterm=bold
  endif
  
  if g:bestwhite_dim_punctuation
    hi Delimiter guifg=#5c6873 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Operator guifg=#5c6873 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  else
    hi Delimiter guifg=#000000 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Operator guifg=#000000 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  endif
  
  unlet s:t_Co
  finish
endif

" 256 color terminal support would go here
" (omitted for brevity - follow same pattern as bestblack)

unlet s:t_Co
