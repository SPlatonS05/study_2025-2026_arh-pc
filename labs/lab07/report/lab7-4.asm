%include 'in_out.asm'

SECTION .data
    msg_x db 'Введите x: ', 0
    msg_a db 'Введите a: ', 0
    result_msg db 'Результат f(x) = ', 0
    func_desc db 'Функция: f(x) = x - a при x >= a, иначе f(x) = 5', 0
    
SECTION .bss
    x resb 10
    a resb 10
    result resb 10

SECTION .text
    global _start

_start:
    ; Вывод описания функции
    mov eax, func_desc
    call sprintLF
    
    ; Ввод переменной x
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread
    mov eax, x
    call atoi
    mov [x], eax
    
    ; Ввод переменной a
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread
    mov eax, a
    call atoi
    mov [a], eax
    
    ; Вычисление функции f(x)
    mov eax, [x]
    mov ebx, [a]
    
    ; Сравниваем x и a
    cmp eax, ebx
    jl less_than    ; Если x < a, переходим к ветке "меньше"
    
    ; Ветка x ≥ a: f(x) = x - a
    sub eax, ebx
    jmp store_result
    
less_than:
    ; Ветка x < a: f(x) = 5
    mov eax, 5
    
store_result:
    mov [result], eax
    
    ; Вывод результата
    mov eax, result_msg
    call sprint
    mov eax, [result]
    call iprintLF
    
    ; Завершение программы
    call quit
