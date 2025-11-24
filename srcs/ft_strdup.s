; fonction ft_strdup
; Duplique une string en allouant de la memoire
; Entree : RDI = pointeur vers la string source
; Sortie : RAX = pointeur vers la nouvelle string (ou NULL si erreur)

global ft_strdup
extern ft_strlen
extern ft_strcpy
extern malloc
extern __errno_location

ft_strdup:
    push rbp
    mov rbp, rsp
    push rbx                    
    push r12                    ; Sauvegarde R12 pour stocker src
    
    mov r12, rdi                ; R12 = src (on sauvegarde car malloc va ecraser RDI)
    
    call ft_strlen              ; RAX = strlen(src)
    inc rax                     ; RAX = strlen(src) + 1 (pour le '\0')
    
    mov rdi, rax                ; RDI = taille à allouer
    push rdi                    ; Sauvegarde la taille
    call malloc wrt ..plt       ; RAX = malloc(size)
    pop rdi                     ; Restore 
    
    test rax, rax               ; test si RAX == NULL
    jz .error                   ; Si NULL, on retourne NULL
    
    mov rdi, rax                ; RDI = dest (nouvelle string)
    mov rsi, r12                ; RSI = src (string originale)
    push rax                    ; Sauvegarde le pointeur dest
    call ft_strcpy              ; ft_strcpy(dest, src)
    pop rax                     ; RAX = pointeur vers la nouvelle string
    
    pop r12
    pop rbx
    pop rbp
    ret

.error:
    xor rax, rax                ; RAX = NULL
    pop r12
    pop rbx
    pop rbp
    ret