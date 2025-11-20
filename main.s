; on definie start comme variable global a tous le systeme
; hello world test
section .data
msg: DB 'Hello World!', 10, 0 ; le 0 cest pour dire on le termine
result_msg: DB 'Length: ', 0 

section .bss
digit_buff: resb 20
global _start
extern ft_strlen

section .text

_start:
    ; appel ft_strlen on return rax donc ici rax vaut la taille de helloworld
    mov rdi, msg        ; on met msg dans rdi car rdi est le parametre passer dans ft_strlen
    call ft_strlen

    ; write(1, msg,msgSize)
    mov rdi, 1          ; arg1: fd = stdout
    mov rsi, msg        ; arg2: buffer
    mov rdx, rax        ; arg3: count
    mov rax, 1
    syscall
    
    ; exit(0)
    mov rax, 60         ; syscall number: sys_exit (60 en 64-bit)
    mov rdi, 0          ; arg1: status = 0
    syscall             ; int 0x80 -> 32 bit | syscall -> 64 bit 
    ; PAS de ret ici ! Le programme se termine avec exit
    ; ret ; ret = return mais quand on exit et que ret est appele alors il return a un endroit quil  ne conais pas 