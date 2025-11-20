; fonction ft_strlen
; retourne la taille de la string
; Entree : RDI = pointeur vers la string
; Sortie; RAX = longueur de la string 

global  ft_strlen; defini une fonctction

ft_strlen: ; etiquette pour call 
    push rbp ; sauvegarde rbp sur la pile
    mov rbp, rsp ; on creer une nouvelle stack frame

    xor rax, rax ; on initialise le compteur a 0

.loop:
   cmp byte [rdi + rax], 0   ; compare le byte à l'adresse (RDI + RAX) avec 0
                              ;    C'est comme str[i] en C
                              ;    "byte" = on lit 1 octet (un caractère)
    je .end                 ; je = jump if egal -> .end
    inc rax                 ; = rax++ ou i++
    jmp .loop               ; on reviens a loop

.end:
    pop rbp
    ret




    