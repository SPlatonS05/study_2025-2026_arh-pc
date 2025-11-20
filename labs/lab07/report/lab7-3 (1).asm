%include 'in_out.asm'

SECTION .data
    msg_a db 'Введите a: ', 0
    msg_b db 'Введите b: ', 0  
    msg_c db 'Введите c: ', 0
    result_msg db 'Наименьшее число: ', 0
    
SECTION .bss
    a resb 10
    b resb 10
    c resb 10
    min resb 10

SECTION .text
    global _start

_start:
    ; Ввод переменной a
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread
    mov eax, a
    call atoi
    mov [a], eax
    
    ; Ввод переменной b
    mov eax, msg_b
    call sprint
    mov ecx, b
    mov edx, 10
    call sread
    mov eax, b
    call atoi
    mov [b], eax
    
    ; Ввод переменной c
    mov eax, msg_c
    call sprint
    mov ecx, c
    mov edx, 10
    call sread
    mov eax, c
    call atoi
    mov [c], eax
    
    ; Находим наименьшее число
    mov eax, [a]     ; Предполагаем, что a - наименьшее
    mov [min], eax
    
    ; Сравниваем с b
    mov ebx, [b]
    cmp eax, ebx
    jle check_c      ; Если a <= b, переходим к проверке c
    mov [min], ebx   ; Иначе наименьшее = b
    mov eax, ebx
    
check_c:
    ; Сравниваем текущее наименьшее с c
    mov ecx, [c]
    cmp eax, ecx
    jle print_result ; Если текущее наименьшее <= c, выводим результат
    mov [min], ecx   ; Иначе наименьшее = c
    
print_result:
    ; Вывод результата
    mov eax, result_msg
    call sprint
    mov eax, [min]
    call iprintLF
    
    ; Завершение программы
    call quit
