.section .init, "ax"
.global _start
_start:
    .cfi_startproc
    .cfi_undefined ra
    .option push
    .option norelax
    la gp, _gp
    .option pop
    la sp, stack_top
    add s0, sp, zero
    jal zero, main
    .cfi_endproc
    .end
