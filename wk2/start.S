.global Reset_Handler

vector_table:
b Reset_Handler 

Reset_Handler:    
    // Set stack pointer to Reset_Handler
    ldr r3, =Reset_Handler
    mov sp, r3

    // Initialize bss section
    // This section contains uninitialized global data
    ldr r0, =_bss
    ldr r1, =_bss_size
    mov r4, #0
init_bss:
    cmp r1, #0
    beq jump_c
load_zero:
    str r4, [r1], #8
    sub r1, r1, #1
    cmp r1, #0
    bne load_zero 

jump_c:
    bl main
    b Reset_Handler
