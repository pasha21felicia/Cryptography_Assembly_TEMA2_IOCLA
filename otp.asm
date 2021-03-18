%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher

    
    ;PRINTF32 `%x\n\x0`, edx
    ;PRINTF32 `%x\n\x0`, esi
    ;PRINTF32 `%x\n\x0`, edi
    ;PRINTF32 `%d\n\x0`, ecx

otp_cr:                 ;varianta 1
    movzx eax, byte [esi]       ;parcurg cate un octet din esi
    mov ebx, [edi]          ;pastrez octetul din cheie
    xor eax, ebx        ;fac xor pe octetii curenti din cheie si plaintext
    mov [edx], eax      ;plasez caracterul rezultat in ciphertext
    inc edx
    inc edi
    inc esi         ;parcurg toate cele trei siruri
    loop otp_cr

;otp_crypt:             ;varianta 2
    ;mov al, [esi]
    ;mov bl, [edi]
    ;xor al, bl
    ;mov [edx], al;
    ;inc edx
    ;inc edi
    ;inc esi
    ;loop otp_crypt

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY