// ; on definie start comme variable global a tous le systeme
// ; hello world test
// section .data
// msg: DB 'Hello World!', 10, 0 ; le 0 cest pour dire on le termine
// src: DB 'Source!', 0
// dest: times 20 DB 0

// section .text
// global _start
// extern ft_strlen
// extern ft_write
// extern ft_read
// extern ft_strcpy

// _start:
//     ; appel ft_strlen on return rax donc ici rax vaut la taille de helloworld
//     mov rdi, msg        ; on met msg dans rdi car rdi est le parametre passer dans ft_strlen
//     call ft_strlen

//     ; write(1, msg,msgSize)
//     mov rdi, 1          ; arg1: fd = stdout
//     mov rsi, msg        ; arg2: buffer
//     mov rdx, rax        ; arg3: count
//     call ft_write
//     ; mov rax, 1          ; sys_write
//     syscall
//     ; regarder le retour de syscall

//     ; appel ft_strlen
//     mov rdi, dest
//     mov rsi, src
//     call ft_strcpy ; rax a mtn copier src
//     push rax ; on save dest sur la pile

//     mov rdi, rax
//     call ft_strlen
//     mov rdx, rax
//     pop rsi
//     mov rdi, 1
//     mov rax, 1
//     syscall
//     ; regarder le retour de syscall

//     ; exit(0)
//     mov rax, 60         ; syscall number: sys_exit (60 en 64-bit)
//     mov rdi, 0          ; arg1: status = 0
//     syscall             ; int 0x80 -> 32 bit | syscall -> 64 bit
//     ; regarder le retour de syscall

//     ; PAS de ret ici ! Le programme se termine avec exit
//     ; ret ; ret = return mais quand on exit et que ret est appele alors il return a un endroit quil  ne conais pas

#include "libasm.h"
int main(void)
{
    // ===== Test ft_strlen =====
    printf("=== ft_strlen ===\n");
    char *str1 = "Hello World!";
    size_t len = ft_strlen(str1);
    printf("ft_strlen(\"%s\") = %zu\n", str1, len);
    printf("strlen(\"%s\") = %zu\n\n", str1, strlen(str1));

    // ===== Test ft_strcpy =====
    printf("=== ft_strcpy ===\n");
    char dest[50];
    ft_strcpy(dest, "Bonjour!");
    printf("ft_strcpy result: \"%s\"\n\n", dest);

    // ===== Test ft_strcmp =====
    printf("=== ft_strcmp ===\n");
    printf("strcmp(\"abc\", \"abc\") = %d\n", strcmp("abc", "abc"));
    printf("ft_strcmp(\"abc\", \"abc\") = %d\n", ft_strcmp("abc", "abc"));

    printf("strcmp(\"abc\", \"def\") = %d\n", strcmp("abc", "def"));
    printf("ft_strcmp(\"abc\", \"def\") = %d\n", ft_strcmp("abc", "def"));

    // ===== Test ft_strdup =====
    printf("=== ft_strdup ===\n");
    char *dup = ft_strdup("Hello!");
    printf("ft_strdup(\"Hello!\") = \"%s\"\n", dup);
    printf("Address: %p\n", (void *)dup);
    free(dup);

    // ===== Test ft_write =====
    printf("=== ft_write ===\n");
    ssize_t ret = ft_write(1, "Test ft_write\n", 14);
    printf("ft_write returned: %zd\n", ret);

    // Test avec erreur (fd invalide)
    errno = 0;
    ret = ft_write(999, "test", 4);
    printf("ft_write(fd=999) returned: %zd\n", ret);
    printf("errno = %d (%s)\n\n", errno, strerror(errno));

    // ===== Test ft_read =====
    printf("=== ft_read ===\n");
    // Test avec erreur (fd invalide)
    char buffer[100];
    errno = 0;
    ret = ft_read(999, buffer, 10);
    printf("ft_read(fd=999) returned: %zd\n", ret);
    printf("errno = %d (%s)\n\n", errno, strerror(errno));

    return 0;
}