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

    // Recebe a String "Aba", verifica o indice de inicio e de fim e chama a função palindromo
    la a0, str2
    li a1, 0            # a1 = left
    li a2, 2            # a2 = right
    jal ra, is_palindromo

    // Recebe a String "A man, a plan, a canal: Panama", verifica o indice de inicio e de fim e chama a função palindromo
    la a0, str3
    li a1, 0            # a1 = left
    li a2, 29            # a2 = right
    jal ra, is_palindromo

    // Recebe a String "123ab321", verifica o indice de inicio e de fim e chama a função palindromo
    la a0, str4
    li a1, 0            # a1 = left
    li a2, 7           # a2 = right
    jal ra, is_palindromo

    // Recebe a String "Socorram-me, subi no ônibus em Marrocos", verifica o indice de inicio e de fim e chama a função palindromo
    la a0, str5
    li a1, 0            # a1 = left
    li a2, 38           # a2 = right
    jal ra, is_palindromo

    # loop principal, ofereca ao usuario se ele deseja continuar ou não
    

    # Encerrar
    // Encerramento coloca o 10 no registrador a7 e o ecall executa a chamada do a7
    li a7, 10          
    ecall

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
    // O stack pointer desce 4 bytes a pilha e salva o endereço para retorno
    addi sp, sp, -16
    // O sw salva o valor na memória e salva o vetor ra, registrador de retorno, na pilha
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s2, 0(sp)

    #logica recursiva 
    mv s0, a0
    mv s1, a1
    mv s2, a2


    # Retorno:
    

