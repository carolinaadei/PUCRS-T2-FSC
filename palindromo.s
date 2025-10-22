# ------------------------------------------------------------
# palindromo.s — (RISC-V / RARS)
# - Trabalho 2
# - Saida: "SIM\n" ou "NAO\n" para cada string 
# ------------------------------------------------------------
# Integrantes do Grupo (até 4 alunos):
# -> Carolina de Souza Gonçalves
# -> Lucas Arieta Pereira da Silva 
# -> Pedro Henrique de Oliveira Silveira
# -> Régis Augusto Martins Xavier Júnior
# -----------------------------------------------------------
    .data
str1: .asciz "radar"
str2: .asciz "Aba"
str3: .asciz "A man, a plan, a canal: Panama"
str4: .asciz "123ab321"
str5: .asciz "Socorram-me, subi no ônibus em Marrocos"
str6: .asciz " "
str7: .asciz "!!!"

yes_str: .asciz "SIM\n"
no_str:  .asciz "NAO\n"

ask_continue: .asciz "Deseja testar outra string? (s/n): "
ask_input:    .asciz "Digite uma string para testar: "
user_answer:  .space 2
input_str:    .space 100

    .text
    .globl main

# O bloco data define strings de teste, mensagens de resultado e espaços para entrada do usuário. 
# O bloco text indica o início do código executável e globl main define a entrada principal do programa.

# ------------------------------------------------------------
# main: chama is_palindromo para cada string de exemplo
# ------------------------------------------------------------
main:
    la a0, str1
    li a1, 0
    li a2, 4
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str2
    li a1, 0
    li a2, 2
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str3
    li a1, 0
    li a2, 29
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str4
    li a1, 0
    li a2, 7
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str5
    li a1, 0
    li a2, 38
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str6
    li a1, 0
    li a2, 0
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str7
    li a1, 0
    li a2, 2
    jal ra, is_palindromo
    jal ra, print_result

# O bloco main realiza testes iniciais, carregando endereço, definindo índices de início e fim e chamando a função de verificação recursiva.
# Depois chama print_result para exibir o resultado.

# ------------------------------------------------------------
# Loop principal para interação com usuário
# ------------------------------------------------------------
main_loop:
    la a0, ask_continue
    li a7, 4
    ecall

    la a0, user_answer
    li a1, 2
    li a7, 8
    ecall

    la t4, user_answer
    lbu t0, 0(t4)
    li t1, 's'
    li t2, 'S'
    beq t0, t1, ask_string
    beq t0, t2, ask_string
    j exit_program

# Pergunta se o usuário deseja continuar. Se a resposta for 's' ou 'S', chama ask_string; caso contrário, encerra o programa.

ask_string:
    la a0, ask_input
    li a7, 4
    ecall

    la a0, input_str
    li a1, 100
    li a7, 8
    ecall

    la t0, input_str
    li t1, 0
count_len:
    lbu t2, 0(t0)
    beqz t2, got_length
    addi t0, t0, 1
    addi t1, t1, 1
    j count_len
got_length:
    addi t1, t1, -1

    la a0, input_str
    li a1, 0
    mv a2, t1
    jal ra, is_palindromo
    jal ra, print_result

    j main_loop

# O bloco ask_string solicita que o usuário digite uma string, determina seu último índice e chama a função recursiva.
# Em seguida, imprime o resultado e retorna ao loop principal.

exit_program:
    li a7, 10
    ecall

# Encerra o programa usando a syscall exit.

print_result:
    beq a0, x0, print_no
    la a0, yes_str
    li a7, 4
    ecall
    jr ra
print_no:
    la a0, no_str
    li a7, 4
    ecall
    jr ra

# O bloco print_result imprime "SIM" ou "NAO" de acordo com o valor em a0.

# ------------------------------------------------------------
# is_palindromo(base, left, right) -> a0 = 1 (SIM) / 0 (NAO)
# ------------------------------------------------------------
is_palindromo:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s2, 0(sp)

    mv s0, a0
    mv s1, a1
    mv s2, a2

skip_left:
    bge s1, s2, base_case
    add t0, s0, s1
    lbu t1, 0(t0)
    mv a0, t1
    jal ra, is_alnum_ascii
    beq a0, x0, inc_left
    j skip_right

inc_left:
    addi s1, s1, 1
    j skip_left

skip_right:
    bge s1, s2, base_case
    add t0, s0, s2
    lbu t1, 0(t0)
    mv a0, t1
    jal ra, is_alnum_ascii
    beq a0, x0, dec_right
    j compare_chars

dec_right:
    addi s2, s2, -1
    j skip_right

base_case:
    li a0, 1
    j end_pal

compare_chars:
    add t0, s0, s1
    lbu t1, 0(t0)
    mv a0, t1
    jal ra, to_lower_ascii
    mv t2, a0

    add t0, s0, s2
    lbu t1, 0(t0)
    mv a0, t1
    jal ra, to_lower_ascii
    mv t3, a0

    bne t2, t3, not_pal

    mv a0, s0
    addi a1, s1, 1
    addi a2, s2, -1
    jal ra, is_palindromo
    j end_pal

not_pal:
    li a0, 0

end_pal:
    lw ra, 12(sp)
    lw s0, 8(sp)
    lw s1, 4(sp)
    lw s2, 0(sp)
    addi sp, sp, 16
    jr ra

# O bloco is_palindromo realiza a recursão completa, pulando caracteres não alfanuméricos e comparando caracteres convertidos para minúsculo.
# Retorna 1 se for palíndromo e 0 se não for, restaurando o contexto ao final.

is_alnum_ascii:
    li t0, '0'
    li t1, '9'
    blt a0, t0, check_AZ
    bgt a0, t1, check_AZ
    li a0, 1
    jr ra
check_AZ:
    li t0, 'A'
    li t1, 'Z'
    blt a0, t0, check_az
    bgt a0, t1, check_az
    li a0, 1
    jr ra
check_az:
    li t0, 'a'
    li t1, 'z'
    blt a0, t0, not_alnum
    bgt a0, t1, not_alnum
    li a0, 1
    jr ra
not_alnum:
    li a0, 0
    jr ra

# O bloco is_alnum_ascii verifica se o caractere está entre '0'-'9', 'A'-'Z' ou 'a'-'z'.
# Retorna 1 se for alfanumérico ou 0 se não for.

to_lower_ascii:
    li t0, 'A'
    li t1, 'Z'
    blt a0, t0, done_lower
    bgt a0, t1, done_lower
    addi a0, a0, 32
done_lower:
    jr ra

# O bloco to_lower_ascii converte letras maiúsculas para minúsculas. Caracteres fora do intervalo permanecem inalterados.
