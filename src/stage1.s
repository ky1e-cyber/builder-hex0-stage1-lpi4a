.global _start
.global uart_putc
.section .text

.equ UART0_BASE, 0xFFE7014000
.equ BINARY_SIZE, 0x100000

# s11 -- assembled program start

_start:
        auipc s11, 0
        addi s11, s11, BINARY_SIZE

        la s1, payload
        # s1 -- read address
        # s2 -- char
        
        read_loop:
                
                j read_loop

        read_loop_end:
        halt:	j halt


# a0 -- char to display
uart_putc:
        li a1, UART0_BASE
        sb a0, (a1)
        ret

payload:
