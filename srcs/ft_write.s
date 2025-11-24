; ssize_t ft_write(int fd, const void *buf, size_t count);
; Entree : RDI = FD, RSI = buf, RDX = count
; Retourne : nombre de bytes écrits, ou -1 en cas d'erreur

global ft_write
extern __errno_location

ft_write:
    push rbp
    mov rbp, rsp
    
    mov rax, 1          ; sys_write
    syscall
    
    cmp rax, 0
    jl .error           ; jump if negatif 
    
    pop rbp
    ret

.error:
    neg rax             ; RAX = -(-9) = 9 (inverser le signe)
    
    push rax            
    
    call __errno_location wrt ..plt ; RAX = adresse de errno
    
    pop rdx             ; RDX = code d'erreur (9)
    mov [rax], rdx      ; *errno = 9
    
    mov rax, -1         ; Retourner -1
    pop rbp
    ret