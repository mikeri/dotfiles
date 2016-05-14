" Vim syntax file
"
" Language:	KickAssembler (C64 assembler)
" Maintainer:	Michael Ilsaas <mikeri@mikeri.net>
" Last Change:	2013 Apr 20
" 
" Loosely based on the GNU Assembler syntax by
" Erik Wognsen <erik.wognsen@gmail.com>
"
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif
let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn match mnemonic "\<adc\>"
syn match mnemonic "\<ahx\>"
syn match mnemonic "\<alr\>"
syn match mnemonic "\<anc\>"
syn match mnemonic "\<anc2\>"
syn match mnemonic "\<and\>"
syn match mnemonic "\<arr\>"
syn match mnemonic "\<asl\>"
syn match mnemonic "\<axs\>"
syn match mnemonic "\<bcc\>"
syn match mnemonic "\<bcs\>"
syn match mnemonic "\<beq\>"
syn match mnemonic "\<bit\>"
syn match mnemonic "\<bmi\>"
syn match mnemonic "\<bne\>"
syn match mnemonic "\<bpl\>"
syn match mnemonic "\<brk\>"
syn match mnemonic "\<bvc\>"
syn match mnemonic "\<bvs\>"
syn match mnemonic "\<clc\>"
syn match mnemonic "\<cld\>"
syn match mnemonic "\<cli\>"
syn match mnemonic "\<clv\>"
syn match mnemonic "\<cmp\>"
syn match mnemonic "\<cpx\>"
syn match mnemonic "\<cpy\>"
syn match mnemonic "\<dcp\>"
syn match mnemonic "\<dec\>"
syn match mnemonic "\<dex\>"
syn match mnemonic "\<dey\>"
syn match mnemonic "\<eor\>"
syn match mnemonic "\<inc\>"
syn match mnemonic "\<inx\>"
syn match mnemonic "\<iny\>"
syn match mnemonic "\<isc\>"
syn match mnemonic "\<jmp\>"
syn match mnemonic "\<jsr\>"
syn match mnemonic "\<las\>"
syn match mnemonic "\<lax\>"
syn match mnemonic "\<lda\>"
syn match mnemonic "\<ldx\>"
syn match mnemonic "\<ldy\>"
syn match mnemonic "\<lsr\>"
syn match mnemonic "\<nop\>"
syn match mnemonic "\<ora\>"
syn match mnemonic "\<pha\>"
syn match mnemonic "\<php\>"
syn match mnemonic "\<pla\>"
syn match mnemonic "\<plp\>"
syn match mnemonic "\<rla\>"
syn match mnemonic "\<rol\>"
syn match mnemonic "\<ror\>"
syn match mnemonic "\<rra\>"
syn match mnemonic "\<rti\>"
syn match mnemonic "\<rts\>"
syn match mnemonic "\<sax\>"
syn match mnemonic "\<sbc\>"
syn match mnemonic "\<sbc\>"
syn match mnemonic "\<sec\>"
syn match mnemonic "\<sed\>"
syn match mnemonic "\<sei\>"
syn match mnemonic "\<shx\>"
syn match mnemonic "\<shy\>"
syn match mnemonic "\<slo\>"
syn match mnemonic "\<sre\>"
syn match mnemonic "\<sta\>"
syn match mnemonic "\<stx\>"
syn match mnemonic "\<sty\>"
syn match mnemonic "\<tas\>"
syn match mnemonic "\<tax\>"
syn match mnemonic "\<tay\>"
syn match mnemonic "\<tsx\>"
syn match mnemonic "\<txa\>"
syn match mnemonic "\<txs\>"
syn match mnemonic "\<tya\>"
syn match mnemonic "\<xaa\>"

syn match asmLabel		"[a-z_][a-z0-9_]*:"he=e-1
syn match decNumber		"\<[0-9]\d*"
syn match hexNumber		"\$[0-9a-fA-F]\+"
syn match binNumber		"%[0-1]*"
syn match decValue		"#[0-9]*"
syn match hexValue		"#\$[0-9a-fA-F]\+"
syn match binValue		"#%[0-1]*"
syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/
syn keyword asmTodo		contained TODO

syn region asmComment		start="/\*" end="\*/" contains=asmTodo
syn region asmComment		start="//" end="$" keepend contains=asmTodo

syn match asmInclude		"\.include"
syn match asmCond		"\.if"
syn match asmLoop		"\.for"

syn match scriptDirective		"\.var\+"
syn match scriptDirective		"\.eval\+"
syn match scriptDirective		"\.const\+"
syn match scriptDirective		"\.enum\+"
syn match scriptDirective		"\.label\+"
syn match scriptDirective		"\.function\+"
syn match scriptDirective		"\.return\+"
syn match scriptDirective		"\.pseudocommand\+"

syn match memDirective		"\.pc\+"
syn match memDirective		"\.pseudopc\+"
syn match memDirective		"\.align\+"
syn match memDirective		"\.struct\+"

syn match dataDirective		"\.byte\+"
syn match dataDirective		"\.word\+"
syn match dataDirective		"\.dword\+"
syn match dataDirective		"\.fill\+"

syn match importDirective		"\.import\+"
syn match importDirective		"\.import source\+"
syn match importDirective		"\.import binary\+"
syn match importDirective		"\.import c64\+"
syn match importDirective		"\.import text\+"

syn match outputDirective		"\.print\+"
syn match outputDirective		"\.printnow\+"

syn case match

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet

	" The default methods for highlighting.  Can be overridden later
highlight link asmSection	Special
highlight link asmLabel	Label
highlight link asmComment	Comment
highlight link asmTodo	Todo
highlight link asmDirective	Statement
highlight link mnemonic	Function

highlight link asmInclude	Include
highlight link asmCond	Conditional
highlight link asmLoop	Repeat
highlight link asmMacro	Macro

highlight link hexNumber	Identifier
highlight link decNumber	Identifier
highlight link binNumber	Identifier

highlight link hexValue	Number
highlight link decValue	Number
highlight link binValue	Number

highlight link asmIdentifier	Identifier
highlight link asmType	Type
highlight link string	String
highlight link importDirective	Function
highlight link outputDirective	Function
highlight link dataDirective	Type
highlight link memDirective	Structure
highlight link scriptDirective	Keyword

highlight link potionString String

let b:current_syntax = "asm"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
