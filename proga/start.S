.global _start
_start:
    la sp, __C_STACK_TOP__
    la gp, 0x0000aa00
    call main
