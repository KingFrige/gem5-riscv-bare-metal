.section .init, "ax"
.global _start
_start:
    .cfi_startproc
    .cfi_undefined ra
    .option push
    .option norelax
    csrr   t0, mhartid
    lui    t1, 0
    beq    t0, t1, 2f

1:  wfi
    j      1b

2:
    la gp, _gp
    .option pop
    la sp, stack_top
    add s0, sp, zero
    jal zero, main
    .cfi_endproc
    .end
