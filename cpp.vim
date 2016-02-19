let c_no_curly_error=1
" Vim syntax file
" Language:	C++
" Maintainer:	Leonid Volnitsky <leonid@volnitsky.com>
" Based on on vim syntax file by Ken Shan

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/c.vim
else
  runtime! syntax/c.vim
  unlet b:current_syntax
endif

" C++ extentions
syn keyword cppStatement	new delete this friend using
syn keyword cppAccess		public protected private
syn keyword cppExceptions	throw try catch
syn keyword cppOperator		operator typeid
syn keyword cppOperator		and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*<"me=e-1
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*$"
syn keyword cppStorageClass	mutable
syn keyword cppStructure	typename namespace
syn keyword cppNumber		NPOS
syn keyword cppBoolean		true false

" The minimum and maximum operators in GNU C++
syn match cppMinMax "[<>]?"

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppAccess		cppStatement
  HiLink cppCast		cppStatement
  HiLink cppExceptions		Exception
  HiLink cppOperator		Operator
  HiLink cppStatement		Statement
  HiLink cppType		Type
  HiLink cppStorageClass	StorageClass
  HiLink cppStructure		Structure
  HiLink cppNumber		Number
  HiLink cppBoolean		Boolean
  delcommand HiLink
endif

let b:current_syntax = "cpp"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" lvv
syn clear	  cppStorageClass
syn keyword	cppStorageClass	typedef static register auto volatile extern const extern external explicit virtual constexpr


""""""""""""""""""""""""""""""""" general keywords
syn keyword	cppStatement	new delete this friend

hi def link cStatement		Statement
hi def link cppStatement	Statement
hi def link cReturn		Statement
hi 	Statement	ctermfg=179

" errors
"syn keyword		DoError           
"hi DoError		ctermfg=133
hi cppExceptions	ctermfg=133

syn keyword		cppOut           cerr cout endl hex dec setw flush setfill scientific setprecision fixed boolalpha noboolalpha 
syn match 		cppOut		"<<"
hi cppOut		ctermfg=105


"""""""""""""""""""""""""""""""" Structures
syn clear	cStructure
syn clear	cppStructure	
syn keyword	cStructure	union enum 

hi def link cStatement		Structure
hi def link cppStatement	Structure
hi Structure	ctermfg=44

syn match	cppTemplate	"\<template\s*<\(\i\|\d\|\s\|,\|=\)*>"
syn keyword	cppTemplate	template
hi cppTemplate	ctermfg=100
"""""""""""""""""""""""""""""""  Statement
"syn clear	cRepeat
hi cConditional ctermfg=214
hi cppConditional ctermfg=214

""""""""""""""""""""""""""""""" macro
hi Include		ctermfg=67
hi PreProc		ctermfg=67
hi cIncluded		ctermfg=39
hi cppIncluded		ctermfg=39

syn match	MacroFunction          	"\(^\s*#\s*define\s\+\)\@<=\<\i\+\ze\s*("
hi MacroFunction	ctermfg=39

""""""""""""""""""""""""""""""" STL Types
syn keyword	cType           void size_type difference_type pointer const_pointer reference const_reference value_type
syn keyword	cppType         string vector deque queue vector array list T iterator pair tuple set map multiset multimap unordered_map unordered_set
syn keyword	cType           ostream istream stringstream ofstream ifstream  ifstream oftstream  ios_base

"""""""""""""""""""""""""""""""" OpencCV Types
syn keyword	cType           Mat Mat_  Mat1b Mat1f Mat3b Mat3f Matx
syn keyword	cType           Point Point_ Size Size_ Rect Rect_ Scalar Scalar_
syn keyword	cType           Ptr uchar

"""""""""""""""""""""""""""""""" Misc Types
syn match	cType           "\<\(\i\+\(_t\|_iterator\|_tag\)\|Q\i\+\)\>\(\s*(\)\@<!"
syn match	cType           "\<\i\+::type\>"
syn keyword	cppType		bool wchar_t qreal
syn keyword	cppType		strr

hi cType	ctermfg=72
hi cType_t	ctermfg=72
hi cppType	ctermfg=72

syn clear	  cStorageClass
syn keyword	  cStorageClass	inline virtual export static register auto volatile extern const explicit using
syn match	  cStorageClass	"\<\(std::\|lvv::\|sto::\:cv::\|cuda::\)"
syn match	  cStorageClass	"\<__attribute__\s*((\s*\i\+\s*))"
hi StorageClass	ctermfg=58

hi String	ctermfg=69
hi String	ctermbg=233
"hi String	ctermbg=285

hi Number	ctermfg=147
hi cppBoolean	ctermfg=147

"""""""""""""""""""""""""""""""""
"syn match	BigClass	"\(>\s*\)\@<=\zs\<\(class\|struct\)\>"
syn match	BigClass	"\(\(^\|;\|>\)\s*\zs\<\(class\|struct\)\)\>"
hi		BigClass	ctermfg=169 

syn match	BigClassName	"\(^\s*\<\(class\|struct\)\>\s*\)\@<=\zs\I\i*\ze" contains=BigClass
hi		BigClassName	ctermfg=46
"ctermbg=16

syn keyword	cStorageClass		typename
syn match	cppStorageClass       	"[<,]\s*\zs\(class\|typename\)"



syn match       Brace                   "{\|}\|!"
hi 		Brace	ctermfg=196

syn match       Paren                   "(\|)"
hi 		Paren	ctermfg=165


" order inportant
syn match       Assign                   "=\|\(+=\)\|\(-=\)\|\(*=\)\|\(/=\)\|\(%=\)"
hi 		Assign			ctermfg=155
syn match       cConditional             "\(==\)\|\(!=\)\|\(>=\)\|\(<=\)"


"syn match Quote /\"/
"hi Quote	ctermfg=222

"""""""""""""""""""""""""""""""  BIG (something that starts from 1st col)
" GOOD! start with \@<= ,  end with \ze
syn match	cBigFunction	contains=cType "\(^\i\(\i\|[*&<> \t]\)\+\)\@<=\<\i\+\ze\(\s*(\(\i\|[*&,<>[\] \t]\)*)\s*{\)"
hi		cBigFunction	ctermfg=226
"ctermbg=16
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"syn match		cFunctionbg             contains=ALL  "^\i\+\s*[*&<> \t]*\s*\<\i\+\s*(\(\i\|[*&,<>[\] \t]\)*)\s*{\zs.*"
"hi cFunctionbg		ctermbg=234

syn match	cFunction	contains=cType	      	"\(^\s*\i\(\i\|[*&<> \t]\)\+\)\@<=\<\i\+\ze\(\s*(\(\i\|[*&,<>[\] \t]\)*)\s*\(const\s*\)\?[:{]\)"
hi		cFunction	ctermfg=226 
"hi		cFunction	ctermfg=226  ctermbg=16
" ctor
syn match	CTOR		contains=cType          "\(^\s*\(explicit\s*\)\?\(\i\+\s*::\s*\)\=\)\@<=\~\?\<\i\+\ze\s*(\(\i\|[*&,<>[\] ]\)*)\s*\(:\s*\i\+\|{\)"
hi 		CTOR		ctermfg=280


syn match	cppTemplate	contains=cType		"\(^\s*\(\i\|[*& \t<>]\)\+\(\i\+\s*::\s*\)\?\<\i\+\s*\)\@<=<\s*\i\+\s*>\ze\s*(\(\i\|[*&,<>[\] \t]\)*)\s*[:{]"

syn  match	Member		contains=cType   	"\(^\s*\(\i\|[*& \t<>]\|\s+\)\+\(\i\+\s*::\s*\)\?\)\@<=\<\i\+\ze\s*<\s*\i\+\s*>\s*(\i\+.*)\s*\(const\s*\)\?[:{]"
hi 		Member		ctermfg=208
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""               SCC           """"""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syn keyword	cRepeat		ALL itALL pALL qALL pLLA
syn keyword	cRepeat		iALL jALL kALL lALL mALL nALL cALL xALL
syn keyword	cRepeat		FOR iFOR jFOR kFOR lFOR nFOR mFOR tFOR ijFOR REP ROF LLA

syn keyword	cRepeat		FOR FORi REP FORitc FORitr
hi cRepeat	ctermfg=198

""""""""""""""""""""""""""""""" SCC Types
syn keyword	cType          idx cint
syn keyword	cType          vint vuint vlong vulong        dint duint dlong dulong
syn keyword	cType          vstr dstr  str
syn keyword	cType          vdouble vfloat ddouble dfloat
" vim: ts=8
