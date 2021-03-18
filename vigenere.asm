%include "io.mac"
section .data
    key_len db 0

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher
    
    mov [key_len], ebx
    xor ebx, ebx

while:                      ;parcurgem plaintext-ul octet cu octet
    movzx eax, byte [esi]

    cmp ebx, [key_len]       ;verificam daca cheia trebuie restaurata
    je fill_in_the_key
    
    cmp eax, 'a'              ;verificam daca caraterul e lowercase
    jge verify_lowercase

    cmp eax, 'A'            ;verificam daca caracterul e capital
    jge verify_capital

    jmp finalize_while    ;nu intra in intervalul lowercase/capital


verify_lowercase:      ;verificam marginea superioara lowercase
    cmp eax, 'z'
    jle convert_lowercase
    jmp finalize_while

verify_capital:         ;verificam marginea superioara capital
    cmp eax, 'Z'
    jle convert_capital
    jmp finalize_while

convert_lowercase:      
    sub eax, 'A'
    add al, byte [edi]      ;adunam octetul din cheie curent cu octetul din plaintext curent
    cmp eax, 'z'         ;daca caracterul gasit depaseste lowercase
    jg compute_letter
    jmp increment_key

convert_capital:        ;exact ca la lowercase principiul
    sub eax, 'A'
    add al, byte [edi]
    cmp eax, 'Z'
    jg compute_letter
    jmp increment_key

compute_letter:         ;va scadea din caracterul cifrat 26 
    sub eax, 26
    jmp increment_key

fill_in_the_key:        ;restaureaza cheia pana la primul caracter
    cmp ebx, 0
    je while
    dec edi
    dec ebx
    jmp fill_in_the_key

increment_key:          ;trece la urmatorul octet din cheie
    inc edi
    inc ebx

finalize_while:         ;trecere la urmatorul caracter din esi
    inc esi
    mov byte [edx], al     ;plaseaza caracterul gasit in ciphertext
    inc edx   
    loop while
exit:
    popa
    leave
    ret
    ;; DO NOT MODIFY