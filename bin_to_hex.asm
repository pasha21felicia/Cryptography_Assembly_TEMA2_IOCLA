%include "io.mac"

section .data
    len_input db 0
    len_output db 0
    index db 0


section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex

    xor ebx, ebx
    xor edi, edi
    xor eax, eax
    mov [len_input], ecx

find_len_output:      ;gaseste lungimea sirului de output prin impartirea lungimii initiale la 4
    mov eax, ecx
    mov bl, 4
    div bl
    xor ebx, ebx

    cmp ah, 0       
    jg adun1           ;daca restul impartirii ah > 0 voi aduna la catul (al) + 1 pentru lungimea de output
    jmp put_len

adun1:
    inc al

put_len:         ;cazul cand sunt exact blocuri de 4, lungimea de output este catul
    mov [len_output], al
    xor eax, eax
    xor ebx, ebx

    mov eax, 0x0A           
    mov ebx, [len_output]   ; pune caracterul '\n' la pozitia len_output in sirul final edx
    mov [edx+ebx], eax      ; comanda asta pune caracterul in edx pe pozitia ebx

    xor eax, eax
    xor ebx, ebx

while:                      ;verifica de la finalul inputului fiecare caracter in grupari de 4
    inc eax                 ; eax va mentine indexul sau pozitia literei in grupare, va avea valori doar intre 1-4
    cmp eax, 1              ; cand caracterul e pozitia 1 inseamna ca el va avea valoare 1   
    je verif_1

    cmp eax, 2              ;daca caracterul e pe pozitia 2, va avea valoarea 2
    je verif_2

    cmp eax, 3              ;daca e pe pozitia 3 inseamna ca va avea valoarea 4
    je verif_3

    jmp complete_nibble     ;este o grupare completa in care se adauga 8 (daca trebuie) si se formeaza caracterul in hex

verif_1:
    cmp byte [esi + ecx - 1], '1'   ;verificare de la sfarsit daca e '1' se aduna daca nu se verifica sa nu se termine sirul
    je adunare_1
    jmp compare
verif_2:
    cmp byte [esi + ecx - 1], '1'
    je adunare_2
    jmp compare
verif_3:
    cmp byte [esi + ecx - 1], '1'
    je adunare_3
    jmp compare


compare:                 ;verifica sa nu fie ecx-lungimea input decrementata pana la 1 ceea ce inseamna ca am ajuns la primul caracter si acesta trebui facut hex
    cmp ecx, 1
    je make_digit         ;gruparile de 3 vor fi mereu cifre
    jmp finalize_while
                        ;in ebx pastrez suma per gruparea de 4
adunare_1: 
    add bl, 1
    jmp compare
adunare_2: 
    add bl, 2
    jmp compare
adunare_3: 
    add bl, 4
    jmp compare
adunare_4: 
    add bl, 8
    jmp find_hex_character

find_hex_character:      ;afla daca e litera sau cifra
    cmp bl, 10
    jl make_digit
    jmp make_letter

complete_nibble:                    ;cazul cand se completeaza gruparea de 4 si se verifica al 4-lea caracter
    cmp byte [esi + ecx - 1], '1'
    je adunare_4

make_digit:             ;facem cifra in hex
    xor eax, eax
    add bl, 48          ;adunam caracterul ascii '0'

    mov eax, [len_output]    ;asta e lungimea care am aflat-o mai sus cu div
    mov [edx+eax-1], bl      ;aici bagam caracterul hex in edx de la sfarsit la inceput
    dec eax                   ;de aia se face dec
    mov [len_output], eax     ;se patreaza lungimea actualizata in variabila

    xor ebx, ebx
    xor eax, eax
    jmp finalize_while

make_letter:
    xor eax, eax
    add bl, 55
    mov eax, [len_output]

    mov [edx+eax-1], bl
    dec eax
    mov [len_output], eax

    xor ebx, ebx
    xor eax, eax
    jmp finalize_while

finalize_while:         ;dupa toate verificarile se merge la urmatorul caracter
    dec ecx
    cmp ecx, 0
    jg while

;PRINTF32 `\n \x0`

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
