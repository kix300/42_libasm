; fonction ft_strcpy
; retourne une copy de la string
; Entree : RDI = dest, RSI = src
; Sortie; RAX = longueur de la string 

global  ft_strcpy; defini une fonctction

ft_strcpy: ; etiquette pour call 
    push rbp ; sauvegarde rbp sur la pile
    mov rbp, rsp ; on creer une nouvelle stack frame
    ; on doit save la source plusieur choix
    ; 1. push rbx -> on save
    ;    mov rbx, rdi
    ;    a la fin on met rbx dans rax et on pop rbx
    ; 2. mov rax, rdi
    mov rax, rdi

; ici on va copier bit par bit tant qu'on n'arrive pas a 0 
.loop:
    mov cl, [rsi]
    mov [rdi], cl
    cmp cl, 0
    je .end                 ; je = jump if egal -> .end
    inc rsi                 
    inc rdi
    jmp .loop               ; on reviens a loop

.end:
    pop rbp
    ret




    