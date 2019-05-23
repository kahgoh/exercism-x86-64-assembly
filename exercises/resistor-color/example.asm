section .data
black: db "black", 0
brown: db "brown", 0
red: db "red", 0
orange: db "orange", 0
yellow: db "yellow", 0
green: db "green", 0
blue: db "blue", 0
violet: db "violet", 0
grey: db "grey", 0
white: db "white", 0

color_array:
dq black
dq brown
dq red
dq orange
dq yellow
dq green
dq blue
dq violet
dq grey
dq white

color_array_len: equ ($ - color_array) / 8

;
; Map color to number.
;
; Parameters:
;   rdi - color
;
; Returns:
;   rax - array index or -1 if not found
;
section .text
global color_code
color_code:
    xor eax, eax                ; Set loop counter to 0
    mov r8, color_array         ; Save color array
.arr_loop_start:
    mov rsi, [r8 + rax * 8]     ; Fetch a color

    xor ecx, ecx                ; Set inner loop counter to 0
    mov dl, byte [rsi + rcx]    ; Fetch a byte
    cmp dl, byte [rdi + rcx]    ; Compare with color parameter
    jne .str_loop_end           ; Not equal => skip loop
.str_loop_start:
    inc ecx                     ; Increment inner loop counter
    mov dl, byte [rsi + rcx]    ; Fetch a byte
    cmp dl, byte [rdi + rcx]    ; Compare with color parameter
    jne .str_loop_end           ; Not equal => exit loop
    test dl, dl                 ; Is it NUL?
    jne .str_loop_start         ; No => next iteration

.str_loop_end:
    cmp dl, byte [rdi + rcx]    ; Found a match?
    je .return                  ; Yes => return array index

    inc eax                     ; Increment loop counter
    cmp eax, color_array_len    ; End of array?
    jne .arr_loop_start         ; No => next iteration

    mov eax, -1                 ; Set return value

.return:
    ret

;
; Get the array of colors.
;
; Returns:
;   rax - array of colors
;
global colors
colors:
    mov rax, color_array        ; Set return value
    ret