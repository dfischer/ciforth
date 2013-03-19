dnl $Id$
dnl Copyright(2011): Albert van der Horst, HCC FIG Holland by GNU Public License
dnl Macro's to adapt the source to Flat Assembler
divert(-1)dnl
define({TITLE},;)dnl Turn TITLE into comment.
define({PAGE},;)dnl Turn PAGE into comment.
define({GLOBAL},{;})dnl Start at first point in executable segment
dnl Take care of embedded double quotes by using single quotes.
dnl Note: this cannot be used in _HEADER, because index must look in the real string,
dnl not on some variable that contains the string.
define({_dbquoted},"{{$1}}")dnl
define({_sgquoted},'{{$1}}')dnl
define({_quoted},{ifelse( -1, index({$1},{"}),{_dbquoted},{_sgquoted})}({{$1}}))
dnl
define({_C},{{;}})
dnl octal
define({_O},{{$1O}})
define({_HEADER_ASM},{;
; FASM version of ciforth created by ``m4'' from generic listing.
; This source can be assembled using the Flat Assembler,
;  available from the Net.
_DLL_(
{;      fasm forth.asm forth
        FORMAT  PE console  ; Instead of telling the linker.
;
        INCLUDE 'include/win32a.inc'      ; ASCII windows definitions.
define({_SECTION_NOBITS_},{})dnl
})_C{}_END_({ _DLL_})
_LINUX_N_(
{;      fasm forth.asm forth
_BITS32_({define({ELF_FORMAT},{ELF})})
_BITS64_({define({ELF_FORMAT},{ELF64})})
        FORMAT  ELF_FORMAT EXECUTABLE ; Instead of telling the linker.
define({_SECTION_NOBITS_},{       SEGMENT executable readable writable})dnl
;
})_C{}_END_({ _LINUX_N_})
;})dnl
define({SET_32_BIT_MODE},{ use32 })dnl
define({SET_64_BIT_MODE},{ use64 })dnl
define({_TEXT},{.text})
define({_SECTION_},       {       SEGMENT executable readable writable})
define({_SECTION_END_},)
dnl Get rid of unknown MASM specifier.
define({_BYTE},)dnl
dnl
define({_ENDP},)dnl Each ENDP is started with _ENDP in generic listing.
define({_EXTRANOP},)dnl where MASM introduces a superfluous NOP
define({RELATIVE_WRT_ORIG}, {$1 - ORIG})
dnl
dnl FASM reserves memory in a sensible way.
define({_RESB}, {RB  ($1) })dnl
dnl
dnl Assembly Pointer
define({_AP_}, {$})dnl
dnl
dnl Second and later uses of ORG shift the program counter
define({_NEW_ORG},
        ORG    $1)dnl
dnl Introduced in behalf of MASM
define({_OR_},{OR})
dnl
dnl Pointer handling
define({_BYTE_PTR},{BYTE PTR $1})dnl
define({_CALL_FAR_INDIRECT},{CALL DWORD PTR [$1]})dnl Perfectly unreasonable!
define({_FAR_ADDRESS},{[$1:$2]})dnl
define({_CELL_PTR},{WORD})dnl Sometimes really needed even after introducing [].
define({_OFFSET},)dnl
define({LONG},{DWORD})dnl
define({QUAD},{QWORD})dnl
dnl
dnl Handling large blocks of comment
dnl This just doesn't work, because fasm syntax checks the content.
dnl define({_COMMENT},{        if 0
dnl })dnl
dnl define({_ENDCOMMENT},{       end if
dnl })dnl
dnl Last possibility of block comment, suppress it in output.
define({_COMMENT},{_SUPPRESSED(})
define({_ENDCOMMENT},{)})
define({_ENDOFPROGRAM},{
_DLL_({
        ENTRY  $1
})_C{}_END_({ _DLL_})
})dnl
define({_ALIGN},{ALIGN    $1})dnl
define({DSS},{DB})dnl
define({EQU},{=})dnl
define({EXTRN},{;})dnl
dnl in behalf of ports
define({_DX16},{{DX}})dnl
define({_AX16},{{AX}})dnl
define({_AX32},{{EAX}})dnl
dnl Work around for nasm. Here needed?
define({A32},{DB 0x67
        })
define({_FASM_}, _yes )
divert{}dnl