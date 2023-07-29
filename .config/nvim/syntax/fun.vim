" Vim syntax file
" Language:     Fun (Toy language for Principles of Programming Language couse)
" Filenames:    *.fun
" Maintainers:  Ahsan

" Quit when a syntax file was already loaded
if exists("b:current_syntax") && b:current_syntax == "fun"
  finish
endif

let s:keepcpo = &cpo
set cpo&vim

" ' can be used in Fun identifiers
setlocal iskeyword+='

" ` is part of the name of polymorphic variants
setlocal iskeyword+=`

" Fun is case sensitive.
syn case match

" Access to the method of an object
syn match    funMethod       "#"

" Script headers highlighted like comments
syn match   funComment  "^#!.*" contains=@Spell
syn match   funComment  "\s*--.*$" contains=@Spell 

" Scripting directives
syn match    funScript "^#\<\(quit\|labels\|warnings\|warn_error\|directory\|remove_directory\|cd\|load\|load_rec\|use\|mod_use\|install_printer\|remove_printer\|require\|list\|ppx\|principal\|predicates\|rectypes\|thread\|trace\|untrace\|untrace_all\|print_depth\|print_length\|camlp4o\|camlp4r\|topfind_log\|topfind_verbose\)\>"

" lowercase identifier - the standard way to match
syn match    funLCIdentifier /\<\(\l\|_\)\(\w\|'\)*\>/

syn match    funKeyChar    "|"

" Errors
syn match    funBraceErr   "}"
syn match    funBrackErr   "\]"
syn match    funParenErr   ")"
syn match    funArrErr     "|]"

syn match    funCommentErr "\*)"

syn match    funCountErr   "\<downto\>"
syn match    funCountErr   "\<to\>"

if !exists("fun_revised")
  syn match    funDoErr      "\<do\>"
endif

syn match    funDoneErr    "\<done\>"
syn match    funThenErr    "\<then\>"

" Error-highlighting of "end" without synchronization:
" as keyword or as error (default)
if exists("fun_noend_error")
  syn match    funKeyword    "\<end\>"
else
  syn match    funEndErr     "\<end\>"
endif

" Some convenient clusters
syn cluster  funAllErrs contains=funBraceErr,funBrackErr,funParenErr,funCommentErr,funCountErr,funDoErr,funDoneErr,funEndErr,funThenErr

syn cluster  funAENoParen contains=funBraceErr,funBrackErr,funCommentErr,funCountErr,funDoErr,funDoneErr,funEndErr,funThenErr

syn cluster  funContained contains=funTodo,funPreDef,funModParam,funModParam1,funMPRestr,funMPRestr1,funMPRestr2,funMPRestr3,funModRHS,funFuncWith,funFuncStruct,funModTypeRestr,funModTRWith,funWith,funWithRest,funModType,funFullMod,funVal


" Enclosing delimiters
syn region   funEncl transparent matchgroup=funKeyword start="(" matchgroup=funKeyword end=")" contains=ALLBUT,@funContained,funParenErr
syn region   funEncl transparent matchgroup=funKeyword start="{" matchgroup=funKeyword end="}"  contains=ALLBUT,@funContained,funBraceErr
syn region   funEncl transparent matchgroup=funKeyword start="\[" matchgroup=funKeyword end="\]" contains=ALLBUT,@funContained,funBrackErr
syn region   funEncl transparent matchgroup=funKeyword start="\[|" matchgroup=funKeyword end="|\]" contains=ALLBUT,@funContained,funArrErr


" Comments
syn keyword  funTodo contained TODO FIXME XXX NOTE


" Objects
syn region   funEnd matchgroup=funObject start="\<object\>" matchgroup=funObject end="\<end\>" contains=ALLBUT,@funContained,funEndErr


" Blocks
if !exists("fun_revised")
  syn region   funEnd matchgroup=funKeyword start="\<begin\>" matchgroup=funKeyword end="\<end\>" contains=ALLBUT,@funContained,funEndErr
endif


" "for"
syn region   funNone matchgroup=funKeyword start="\<for\>" matchgroup=funKeyword end="\<\(to\|downto\)\>" contains=ALLBUT,@funContained,funCountErr


" "do"
if !exists("fun_revised")
  syn region   funDo matchgroup=funKeyword start="\<do\>" matchgroup=funKeyword end="\<done\>" contains=ALLBUT,@funContained,funDoneErr
endif

" "if"
syn region   funNone matchgroup=funKeyword start="\<if\>" matchgroup=funKeyword end="\<then\>" contains=ALLBUT,@funContained,funThenErr

"" PPX nodes

syn match funPpxIdentifier /\(\[@\{1,3\}\)\@<=\w\+\(\.\w\+\)*/
syn region funPpx matchgroup=funPpxEncl start="\[@\{1,3\}" contains=TOP end="\]"

"" Modules

" "sig"
syn region   funSig matchgroup=funSigEncl start="\<sig\>" matchgroup=funSigEncl end="\<end\>" contains=ALLBUT,@funContained,funEndErr,funModule
syn region   funModSpec matchgroup=funKeyword start="\<module\>" matchgroup=funModule end="\<\u\(\w\|'\)*\>" contained contains=@funAllErrs,funComment skipwhite skipempty nextgroup=funModTRWith,funMPRestr

" "open"
syn match   funKeyword "\<hiding\>" skipwhite skipempty nextgroup=funFullMod

" "include"
syn match    funKeyword "\<import\>" skipwhite skipempty nextgroup=funModParam,funFullMod

" "module" - somewhat complicated stuff ;-)
syn region   funModule matchgroup=funKeyword start="\<module\>" matchgroup=funModule end="\<\u\(\w\|'\)*\>" contains=@funAllErrs,funComment skipwhite skipempty nextgroup=funPreDef
syn region   funPreDef start="."me=e-1 matchgroup=funKeyword end="\l\|=\|)"me=e-1 contained contains=@funAllErrs,funComment,funModParam,funGenMod,funModTypeRestr,funModTRWith nextgroup=funModPreRHS
syn region   funModParam start="([^*]" end=")" contained contains=funGenMod,funModParam1,funSig,funVal
syn match    funModParam1 "\<\u\(\w\|'\)*\>" contained skipwhite skipempty
syn match    funGenMod "()" contained skipwhite skipempty

syn region   funMPRestr start=":" end="."me=e-1 contained contains=@funComment skipwhite skipempty nextgroup=funMPRestr1,funMPRestr2,funMPRestr3
syn region   funMPRestr1 matchgroup=funSigEncl start="\ssig\s\=" matchgroup=funSigEncl end="\<end\>" contained contains=ALLBUT,@funContained,funEndErr,funModule
syn region   funMPRestr2 start="\sfunctor\(\s\|(\)\="me=e-1 matchgroup=funKeyword end="->" contained contains=@funAllErrs,funComment,funModParam,funGenMod skipwhite skipempty nextgroup=funFuncWith,funMPRestr2
syn match    funMPRestr3 "\w\(\w\|'\)*\( *\. *\w\(\w\|'\)*\)*" contained
syn match    funModPreRHS "=" contained skipwhite skipempty nextgroup=funModParam,funFullMod

syn region   funVal matchgroup=funKeywordR start="\<val\|rec\>" matchgroup=funLCIdentifier end="\<\l\(\w\|'\)*\>" contains=@funAllErrs,funComment,funFullMod skipwhite skipempty nextgroup=funMPRestr

syn region   funModRHS start="." end=". *\w\|([^*]"me=e-2 contained contains=funComment skipwhite skipempty nextgroup=funModParam,funFullMod
syn match    funFullMod "\<\u\(\w\|'\)*\( *\. *\u\(\w\|'\)*\)*" contained skipwhite skipempty nextgroup=funFuncWith

syn region   funFuncWith start="([^*)]"me=e-1 end=")" contained contains=funComment,funWith,funFuncStruct skipwhite skipempty nextgroup=funFuncWith
syn region   funFuncStruct matchgroup=funStructEncl start="[^a-zA-Z]struct\>"hs=s+1 matchgroup=funStructEncl end="\<end\>" contains=ALLBUT,@funContained,funEndErr

syn match    funModTypeRestr "\<\w\(\w\|'\)*\( *\. *\w\(\w\|'\)*\)*\>" contained
syn region   funModTRWith start=":\s*("hs=s+1 end=")" contained contains=@funAENoParen,funWith
syn match    funWith "\<\(\u\(\w\|'\)* *\. *\)*\w\(\w\|'\)*\>" contained skipwhite skipempty nextgroup=funWithRest
syn region   funWithRest start="[^)]" end=")"me=e-1 contained contains=ALLBUT,@funContained

" "struct"
syn region   funStruct matchgroup=funStructEncl start="\<\(module\s\+\)\=struct\>" matchgroup=funStructEncl end="\<end\>" contains=ALLBUT,@funContained,funEndErr

" "module type"
syn region   funKeyword start="\<module\>\s*\<type\>\(\s*\<of\>\)\=" matchgroup=funModule end="\<\w\(\w\|'\)*\>" contains=funComment skipwhite skipempty nextgroup=funMTDef
syn match    funMTDef "=\s*\w\(\w\|'\)*\>"hs=s+1,me=s+1 skipwhite skipempty nextgroup=funFullMod

" Quoted strings
syn region funString matchgroup=funQuotedStringDelim start="{\z\([a-z_]*\)|" end="|\z1}" contains=@Spell

syn keyword  funKeyword  and as assert class
syn keyword  funKeyword  constraint else
syn keyword  funKeyword  exception external fun

syn keyword  funKeyword  in inherit initializer
syn keyword  funKeyword  lazy let match
syn keyword  funKeyword  method mutable new nonrec of
syn keyword  funKeyword  parser private 
syn keyword  funKeywordR val rec
syn keyword  funKeyword  try type
syn keyword  funKeyword  virtual when while with

if exists("fun_revised")
  syn keyword  funKeyword  do value
  syn keyword  funBoolean  True False
else
  syn keyword  funKeyword  function
  syn keyword  funBoolean  true false
endif

syn keyword  funType     array bool char exn float format format4
syn keyword  funType     int int32 int64 lazy_t list nativeint option
syn keyword  funType     bytes string unit

syn match    funConstructor  "(\s*)"
syn match    funConstructor  "\[\s*\]"
syn match    funConstructor  "\[|\s*>|]"
syn match    funConstructor  "\[<\s*>\]"
syn match    funConstructor  "\u\(\w\|'\)*\>"

" Polymorphic variants
syn match    funConstructor  "`\w\(\w\|'\)*\>"

" Module prefix
syn match    funModPath      "\u\(\w\|'\)* *\."he=e-1

syn match    funCharacter    "'\\\d\d\d'\|'\\[\'ntbr]'\|'.'"
syn match    funCharacter    "'\\x\x\x'"
syn match    funCharErr      "'\\\d\d'\|'\\\d'"
syn match    funCharErr      "'\\[^\'ntbr]'"
syn region   funString       start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell

syn match    funTopStop      ";;"

syn match    funAnyVar       "\<_\>"
syn match    funKeyChar      "|[^\]]"me=e-1
syn match    funKeyChar      ";"
syn match    funKeyChar      "\~"
syn match    funKeyChar      "?"

"" Operators

" The grammar of operators is found there:
"     https://caml.inria.fr/pub/docs/manual-fun/names.html#operator-name
"     https://caml.inria.fr/pub/docs/manual-fun/extn.html#s:ext-ops
"     https://caml.inria.fr/pub/docs/manual-fun/extn.html#s:index-operators
" =, *, < and > are both operator names and keywords, we let the user choose how
" to display them (has to be declared before regular infix operators):
syn match    funEqual        "="
syn match    funStar         "*"
syn match    funAngle        "<"
syn match    funAngle        ">"
" Custom indexing operators:
syn region   funIndexing matchgroup=funIndexingOp
  \ start="\.[~?!:|&$%=>@^/*+-][~?!.:|&$%<=>@^*/+-]*\_s*("
  \ end=")\(\_s*<-\)\?"
  \ contains=ALLBUT,@funContained,funParenErr
syn region   funIndexing matchgroup=funIndexingOp
  \ start="\.[~?!:|&$%=>@^/*+-][~?!.:|&$%<=>@^*/+-]*\_s*\["
  \ end="]\(\_s*<-\)\?"
  \ contains=ALLBUT,@funContained,funBrackErr
syn region   funIndexing matchgroup=funIndexingOp
  \ start="\.[~?!:|&$%=>@^/*+-][~?!.:|&$%<=>@^*/+-]*\_s*{"
  \ end="}\(\_s*<-\)\?"
  \ contains=ALLBUT,@funContained,funBraceErr
" Extension operators (has to be declared before regular infix operators):
syn match    funExtensionOp          "#[#~?!.:|&$%<=>@^*/+-]\+"
" Infix and prefix operators:
syn match    funPrefixOp              "![~?!.:|&$%<=>@^*/+-]*"
syn match    funPrefixOp           "[~?][~?!.:|&$%<=>@^*/+-]\+"
syn match    funInfixOp      "[&$%@^/+-][~?!.:|&$%<=>@^*/+-]*"
syn match    funInfixOp         "[|<=>*][~?!.:|&$%<=>@^*/+-]\+"
syn match    funInfixOp               "#[~?!.:|&$%<=>@^*/+-]\+#\@!"
syn match    funInfixOp              "!=[~?!.:|&$%<=>@^*/+-]\@!"
syn keyword  funInfixOpKeyword      asr land lor lsl lsr lxor mod or
" := is technically an infix operator, but we may want to show it as a keyword
" (somewhat analogously to = for let‐bindings and <- for assignations):
syn match    funRefAssign    ":="
" :: is technically not an operator, but we may want to show it as such:
syn match    funCons         "::"
" -> and <- are keywords, not operators (but can appear in longer operators):
syn match    funArrow        "->[~?!.:|&$%<=>@^*/+-]\@!"
if exists("fun_revised")
  syn match    funErr        "<-[~?!.:|&$%<=>@^*/+-]\@!"
else
  syn match    funKeyChar    "<-[~?!.:|&$%<=>@^*/+-]\@!"
endif

syn match    funNumber        "-\=\<\d\(_\|\d\)*[l|L|n]\?\>"
syn match    funNumber        "-\=\<0[x|X]\(\x\|_\)\+[l|L|n]\?\>"
syn match    funNumber        "-\=\<0[o|O]\(\o\|_\)\+[l|L|n]\?\>"
syn match    funNumber        "-\=\<0[b|B]\([01]\|_\)\+[l|L|n]\?\>"
syn match    funFloat         "-\=\<\d\(_\|\d\)*\.\?\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"

" Labels
syn match    funLabel        "\~\(\l\|_\)\(\w\|'\)*"lc=1
syn match    funLabel        "?\(\l\|_\)\(\w\|'\)*"lc=1
syn region   funLabel transparent matchgroup=funLabel start="[~?](\(\l\|_\)\(\w\|'\)*"lc=2 end=")"me=e-1 contains=ALLBUT,@funContained,funParenErr


" Synchronization
syn sync minlines=50
syn sync maxlines=500

if !exists("fun_revised")
  syn sync match funDoSync      grouphere  funDo      "\<do\>"
  syn sync match funDoSync      groupthere funDo      "\<done\>"
endif

if exists("fun_revised")
  syn sync match funEndSync     grouphere  funEnd     "\<\(object\)\>"
else
  syn sync match funEndSync     grouphere  funEnd     "\<\(begin\|object\)\>"
endif

syn sync match funEndSync     groupthere funEnd     "\<end\>"
syn sync match funStructSync  grouphere  funStruct  "\<struct\>"
syn sync match funStructSync  groupthere funStruct  "\<end\>"
syn sync match funSigSync     grouphere  funSig     "\<sig\>"
syn sync match funSigSync     groupthere funSig     "\<end\>"

" Define the default highlighting.

hi def link funBraceErr	   Error
hi def link funBrackErr	   Error
hi def link funParenErr	   Error
hi def link funArrErr	   Error

hi def link funCommentErr   Error

hi def link funCountErr	   Error
hi def link funDoErr	   Error
hi def link funDoneErr	   Error
hi def link funEndErr	   Error
hi def link funThenErr	   Error

hi def link funCharErr	   Error

hi def link funErr	   Error

hi def link funComment	   Comment

hi def link funModPath	   Include
hi def link funObject	   Include
hi def link funModule	   Include
hi def link funModParam1    Include
hi def link funGenMod       Include
hi def link funModType	   Include
hi def link funMPRestr3	   Include
hi def link funFullMod	   Include
hi def link funFuncWith	   Include
hi def link funModParam     Include
hi def link funModTypeRestr Include
hi def link funWith	   Include
hi def link funMTDef	   Include
hi def link funSigEncl	   funModule
hi def link funStructEncl	   funModule

hi def link funScript	   Include

hi def link funConstructor  Constant

hi def link funVal          Keyword
hi def link funModPreRHS    Keyword
hi def link funMPRestr2	   Keyword
hi def link funKeyword	   Keyword
hi def link funKeywordR	   Keyword
hi def link funMethod	   Include
hi def link funArrow	   Keyword
hi def link funKeyChar	   Keyword
hi def link funAnyVar	   Keyword
hi def link funTopStop	   Comment

hi def link funRefAssign    funKeyChar
hi def link funEqual        funKeyChar
hi def link funStar         funInfixOp
hi def link funAngle        funInfixOp
hi def link funCons         funInfixOp

hi def link funPrefixOp       funOperator
hi def link funInfixOp        funOperator
hi def link funExtensionOp    funOperator
hi def link funIndexingOp     funOperator

if exists("fun_highlight_operators")
    hi def link funInfixOpKeyword funOperator
    hi def link funOperator       Operator
else
    hi def link funInfixOpKeyword Keyword
endif

hi def link funBoolean	   Boolean
hi def link funCharacter    Character
hi def link funNumber	   Number
hi def link funFloat	   Float
hi def link funString	   String
hi def link funQuotedStringDelim Identifier

hi def link funLabel	   Identifier

hi def link funType	   Type

hi def link funTodo	   Todo

hi def link funEncl	   Keyword

hi def link funPpxEncl       funEncl

let b:current_syntax = "fun"

let &cpo = s:keepcpo
unlet s:keepcpo

" vim: ts=8
