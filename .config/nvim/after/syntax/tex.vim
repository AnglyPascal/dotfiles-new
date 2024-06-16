syntax match texMathSymbol '\\D\>' contained conceal cchar=d
syntax match texMathSymbol '\\ito\>' contained conceal cchar=•
syntax match texMathSymbol '\\bigcdot\>' contained conceal cchar=•
syntax match texMathSymbol '\\varint\>' contained conceal cchar=∫
syntax match texMathSymbol '\\variint\>' contained conceal cchar=∬
syntax match texMathSymbol '\\variiint\>' contained conceal cchar=∭
syntax match texMathSymbol '\\\(ts\|ds\|cs\)\>' contained conceal
syntax match texMathSymbol '\\qedhere\>' contained conceal
syntax match texMathSymbol '\\leavevmode\>' contained conceal
syntax match texMathSymbol '\^{\\T}' contained conceal cchar=ᵀ
syntax match texMathSymbol '\\suml' contained conceal cchar=∑

syntax match texCmdStyleBold '\\in\(def\|thm\)\>' skipwhite skipnl nextgroup=texStyleBold conceal


highlight def link texRefEnvConcealedArg   texRefArg
highlight def link texRefEnvConcealedDelim texDelim

syntax match texCmdRefEq nextgroup=texRefEnvConcealedArg
      \ conceal skipwhite skipnl "\\\(auto\|thm\|name\|side\)ref\>"
call vimtex#syntax#core#new_arg('texRefEnvConcealedArg', {
      \ 'contains': 'texComment,@NoSpell,texRefEnvConcealedDelim',
      \ 'opts': 'keepend contained',
      \ 'matchgroup': '',
      \})
syntax match texRefEnvConcealedDelim contained "{" conceal cchar=[
syntax match texRefEnvConcealedDelim contained "}" conceal cchar=]

syntax region texComment matchgroup=texCmdConditional start="\\ifextra[ABC]\>" end="\\\%(fi\|else\)\>" contains=texCommentConditionals
