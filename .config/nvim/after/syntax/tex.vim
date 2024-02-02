syntax match texMathSymbol '\\D\>' contained conceal cchar=d
syntax match texMathSymbol '\\varint\>' contained conceal cchar=∫


highlight def link texRefEnvConcealedArg   texRefArg
highlight def link texRefEnvConcealedDelim texDelim

syntax match texCmdRefEq nextgroup=texRefEnvConcealedArg
      \ conceal skipwhite skipnl "\\autoref\>"
call vimtex#syntax#core#new_arg('texRefEnvConcealedArg', {
      \ 'contains': 'texComment,@NoSpell,texRefEnvConcealedDelim',
      \ 'opts': 'keepend contained',
      \ 'matchgroup': '',
      \})
syntax match texRefEnvConcealedDelim contained "{" conceal cchar=[
syntax match texRefEnvConcealedDelim contained "}" conceal cchar=]
