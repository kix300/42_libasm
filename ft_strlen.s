; on definie start comme variable global a tous le systeme
; hello world test
section .data
msg: DB 'Hello World!', 10
msgSize EQU $ - msg

global _start

section .text

_start:
    ; write(1, msg,msgSize)
    mov rax, 1          ; syscall number: sys_write (1 en 64-bit)
    mov rdi, 1          ; arg1: fd = stdout
    mov rsi, msg        ; arg2: buffer
    mov rdx, msgSize    ; arg3: count
    syscall
    
    ; exit(0)
    mov rax, 60         ; syscall number: sys_exit (60 en 64-bit)
    mov rdi, 0          ; arg1: status = 0
    syscall             ; int 0x80 -> 32 bit | syscall -> 64 bit 
    ; PAS de ret ici ! Le programme se termine avec exit
    ; ret ; ret = return mais quand on exit et que ret est appele alors il return a un endroit quil  ne conais pas 