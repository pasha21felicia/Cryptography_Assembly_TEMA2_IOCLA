%include "io.mac"

section .data
    needle_len db 0
    haystack_len db 0
    needle db "", 0
    haystack dw "", 0
    pos db 0

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr

    ;; DO NOT MODIFY

    mov [haystack_len], cl      ;pastrez valoarea lui ecx, caci se va modifica ulterior
    xor ecx, ecx
    mov ah, 0
    mov ah, dl      ;pastrez valoarea lui edx in partea superioara a lui eax

while:              ;loop-ul principal
    mov al, [esi]       
    cmp al, byte [ebx]          ;comparar fiecare litera din esi cu prima
    je check_substring          ;litera din substring 
    jmp finalize_while

check_substring:            
    dec dl                  ;decrementez lungimea substring-ului
    cmp dl, 0               ;daca ea ajunge la 0, inseamna ca substringul a fost gasit in totalitate in haystack
    je print_result_success     

    inc ebx               ;mergem la urmatorul octet din substring si din haystack
    inc esi
    inc cl

    mov al, [esi]

    cmp al, byte [ebx]    ;comparam urmatorii octeti daca sunt egali,
    je check_substring      ; iteram prin acest label

    inc dl              ;daca am detectat ca nu sunt egale, restauram lungimea si mergem 
    dec ebx                ;la inceputul substringului
    jmp finalize_while

print_result_success:   
    sub cl, ah          ;daca s-a gasit substringul in totalitate
    add cl, 1           ;pentru a afla pozitia de inceput, scadem din pozitia curenta lungimea initiala si adaugam 1
    mov [edi], ecx
    jmp exit

print_result_fail:      ;daca nu am gasit substringul
    xor eax, eax
    mov al, [haystack_len]  
    add al, 1           ;adaugam 1 la lungimea haystack-ului
    mov [edi], eax
    jmp exit

finalize_while:         ;iterarea prin haystack in cazul in care nu a fost gasit 
    inc esi             ;un match cu subtringul
    inc cl
    cmp cl, [haystack_len]
    jb while
    jmp print_result_fail  
 


exit:
    popa
    leave
    ret
    ;; DO NOT MODIFY
