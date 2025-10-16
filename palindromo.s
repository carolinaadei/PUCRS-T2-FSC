# ------------------------------------------------------------
# palindromo.s — Esqueleto base (RISC-V / RARS)
# - Trabalho 2
# - Saida: "SIM\n" ou "NAO\n" para cada string
# ------------------------------------------------------------
# Integrantes do Grupo (até 4 alunos):
# -> Carolina de Souza Gonçalves
# -> Lucas Arieta Pereira da Silva 
# -> Pedro Henrique de Oliveira Silveira
# -> Régis Augusto Martins Xavier Júnior
# ------------------------------------------------------------
    .data
str1: .asciz "radar"
str2: .asciz "Aba"
str3: .asciz "A man, a plan, a canal: Panama"
str4: .asciz "123ab321"
str5: .asciz "Socorram-me, subi no ônibus em Marrocos"

yes_str: .asciz "SIM\n"
no_str:  .asciz "NAO\n"

    .text
    .globl main

# ------------------------------------------------------------
# main: chama is_palindromo para cada string de exemplo
# ------------------------------------------------------------
main:
    // Recebe a String "radar", verifica o indice de inicio e de fim e chama a função palindromo
    la a0, str1
    li a1, 0            # a1 = left
    li a2, 4            # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

    // Recebe a String "Aba", verifica o indice de inicio e de fim e chama a função palindromo
    la a0, str2
    li a1, 0            # a1 = left
    li a2, 2            # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

    // Recebe a String "A man, a plan, a canal: Panama", verifica o indice de inicio e de fim e chama a função palindromo
    la a0, str3
    li a1, 0            # a1 = left
    li a2, 29           # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

    // Recebe a String "123ab321", verifica o indice de inicio e de fim e chama a função palindromo
    la a0, str4
    li a1, 0            # a1 = left
    li a2, 7            # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

    // Recebe a String "Socorram-me, subi no ônibus em Marrocos", verifica o indice de inicio e de fim e chama a função palindromo
    la a0, str5
    li a1, 0            # a1 = left
    li a2, 38           # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

    # loop principal, ofereca ao usuario se ele deseja continuar ou não
    

    # Encerrar
    // Encerramento coloca o 10 no registrador a7 e o ecall executa a chamada do a7
    li a7, 10          
    ecall

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

# ------------------------------------------------------------
# is_palindromo(base, left, right) -> a0 = 1 (SIM) / 0 (NAO)
#  - IMPLEMENTE usando recursao:
#    * pular nao-alfanumericos
#    * comparar to_lower_ascii(base[left]) vs to_lower_ascii(base[right])
#    * caso iguais: chamar recursivamente com (left+1, right-1)
#    * caso diferentes: retornar NAO
#    * parada: left >= right => SIM
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

to_lower_ascii:
    li t0, 'A'
    li t1, 'Z'
    blt a0, t0, done_lower
    bgt a0, t1, done_lower
    addi a0, a0, 32
done_lower:
    jr ra
