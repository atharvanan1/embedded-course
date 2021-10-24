// Most of the code is borrowed from 
// https://github.com/bztsrc/raspi3-tutorial/blob/master/02_multicorec/start.S

.global Reset_Handler
.section .text.boot

vector_table:
b Reset_Handler

Reset_Handler:
    // Set stack pointer to Reset_Handler
    mrs x1, mpidr_el1
    and x1, x1, #3
    cbz x1, 2f
    // cpu id > 0, stop
1:  wfe
    b   1b

2:  // cpu id == 0

    // set stack before our code
    ldr x1, =Reset_Handler
    mov sp, x1

    // clear bss
    ldr x1, =_bss
    ldr w2, =_bss_size
3:  cbz w2, 4f
    str xzr, [x1], #8
    sub w2, w2, #1
    cbnz w2, 3b

    // jump to C code, should not return
4:  bl main
    b   1b
