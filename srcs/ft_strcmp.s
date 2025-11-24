; fonction ft_strcmp
; retourne un int : 0 si egual, -1 si s1 < s2 et x>0 si s1 > s2
; Entree : RDI = pointeur vers la premier string s1, RSI = pointeur vers la seconde string s2
; Sortie; RAX = 0, -1 , >0
; ca compare bien la taille des bits

global  ft_strcmp; defini une fonction

ft_strcmp: ; etiquette pour call 
    push rbp ; sauvegarde rbp sur la pile
    mov rbp, rsp ; on creer une nouvelle stack frame

    xor rax, rax ; on initialise le compteur a 0 -> resultats
    xor rcx, rcx ; on initialise le compteur a 0 -> i 

.loop:
    mov al, byte [rdi + rcx]    ; AL = s1[i]  (al = 8 bits low de rax)
    mov bl, byte [rsi + rcx]    ; BL = s2[i]  (bl = 8 bits low de rbx)
    cmp al, bl                  ; on comprae les deux 
    jne .different              ; on jump dans different si les bits sont different

    test al, al                 ; on regarde si s1[i] == '\0'
    jz .end
    inc rcx
    jmp .loop               ; on reviens a loop

.different:
    movzx rax, al               ; RAX = unsigned char s1[i]
    movzx rbx ,bl               ; RBX = unsigned char s2[i] 
    sub rax, rbx

.end:
    pop rbp
    ret