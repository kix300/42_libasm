; ssize_t ft_write(int fd, const void *buf, size_t count);
; Retourne : nombre de bytes écrits, ou -1 en cas d'erreur

global ft_write
extern __errno_location

ft_write:
    push rbp
    mov rbp, rsp
    
    ; Arguments déjà dans les bons registres :
    ; RDI = fd, RSI = buf, RDX = count
    
    mov rax, 1          ; sys_write
    syscall
    
    ; Vérifier si erreur (RAX < 0)
    cmp rax, 0
    jl .error           ; Si négatif, gérer l'erreur
    
    ; Pas d'erreur : retourner RAX (nombre de bytes écrits)
    pop rbp
    ret

.error:
    ; RAX contient -errno (exemple: -9)
    neg rax             ; RAX = -(-9) = 9 (inverser le signe)
    
    push rax            ; Sauvegarder le code d'erreur
    
    call __errno_location wrt ..plt ; RAX = adresse de errno
    
    pop rdx             ; RDX = code d'erreur (9)
    mov [rax], rdx      ; *errno = 9
    
    mov rax, -1         ; Retourner -1
    pop rbp
    ret