%include "io.mac"
section .data
    divisor db 26
    len db 0
section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher

general_case:
    movzx eax, byte[esi]            ;il parcurg pe plaintext octet cu octet

    cmp eax, 'a'            ;veificam daca caracterul este lowercase
    jge verify_lowercase

    cmp eax, 'A'
    jge verify_capital          ;verificam daca caracterul este capital

    jmp put_char                ;daca nu e capital sau lowercase adaugam caracterul asa cum e
    

verify_lowercase:       ;verifica marginea superioasa de lowercase
    cmp eax, 'z'
    jle convert_lowercase      ;am gasit lowercase
    jmp put_char                ;este un alt caracter

verify_capital:             ;verifica marginea superioara de capital
    cmp eax, 'Z'
    jle convert_capital        ;am gasit capital
    jmp put_char            ;este mai mare ca 'Z' asa ca putem caracterul asa cum e

convert_lowercase:       
    add eax, edi        ;adunam caracterul cu keya pentru a ii afla codul ascii
    sub eax, 97          ;scadem caracterul 'a'
    xor ebx, ebx           
    mov bl, [divisor]      ;impartim la 26 dupa aritmetica modulara
    div bl
    xor ebx, ebx
    mov bl, ah             ;retinem restul 
    mov eax, 97             ;adunam restul cu 'a' pentru a afla caracterul cifrat
    add eax, ebx
    jmp put_char

convert_capital:      ;acelasi principiu ca la lowercase
    add eax, edi
    sub eax, 65         ;se scade 'A'
    xor ebx, ebx
    mov bl, [divisor]
    div bl
    xor ebx, ebx
    mov bl, ah
    mov eax, 65         ;se afla caracterul cifrat prin adunarea restului cu 'A'
    add eax, ebx
    jmp put_char

put_char:               ;introducem caracterul cifrat in ciphertext
    mov byte[edx], al
    inc esi
    inc edx
    dec ecx
    cmp ecx, 0
    jg general_case

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY