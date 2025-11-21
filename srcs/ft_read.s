; ssize_t ft_read(int fd, void *buf, size_t count);

global ft_read
extern __errno_location

ft_read:
    push rbp
    mov rbp, rsp
    
    mov rax, 0          ; sys_read
    ; RDI = fd, RSI = buf, RDX = count (déjà définis)
    syscall
    
    cmp rax, 0
    jl .error
    
    pop rbp
    ret

.error:
    neg rax             ; errno = -rax
    push rax
    
    call __errno_location wrt ..plt
    
    pop rdx
    mov [rax], rdx      ; *errno = code
    
    mov rax, -1
    pop rbp
    ret