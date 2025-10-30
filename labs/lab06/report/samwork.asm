%include 'in_out.asm'
SECTION .data
    div: DB 'Выражение для вычисления: y = x^3 * 1/3 + 21', 0
    msg: DB 'Введите x: ', 0
    rem: DB 'Результат вычисления равен: ', 0
    
SECTION .bss
    x resb 10           ; буфер для ввода x
    result resd 1       ; место для хранения результата

SECTION .text
GLOBAL _start
_start:
    ; Выводим выражение для вычисления
    mov eax, div
    call sprintLF
    
    ; Выводим запрос на ввод x
    mov eax, msg
    call sprint
    
    ; Читаем значение x
    mov ecx, x
    mov edx, 10
    call sread
    
    ; Преобразуем строку в число
    mov eax, x
    call atoi
    mov [x], eax
    
    ; Вычисляем x^3
    mov ebx, eax        ; ebx = x
    imul ebx, ebx       ; ebx = x * x = x^2
    imul ebx, [x]       ; ebx = x^2 * x = x^3
    
    ; Вычисляем x^3 * 1/3 (то же самое что x^3 / 3)
    mov eax, ebx        ; eax = x^3
    mov ecx, 3          ; ecx = 3
    cdq                 ; расширяем eax в edx:eax для деления
    idiv ecx            ; eax = x^3 / 3, edx = остаток
    
    ; Прибавляем 21
    add eax, 21         ; eax = (x^3 / 3) + 21
    
    ; Сохраняем результат
    mov [result], eax
    
    ; Выводим сообщение о результате
    mov eax, rem
    call sprint
    
    ; Выводим сам результат
    mov eax, [result]
    call iprintLF
    
    ; Завершаем программу
    call quit
