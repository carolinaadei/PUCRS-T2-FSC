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

    .text
    .globl main

# O bloco data define as Strings de teste e como será a exibição da verificação.
# O text indica o início do código de execução e o globl main é onde começa o programa.

# ------------------------------------------------------------
# main: chama is_palindromo para cada string de exemplo
# ------------------------------------------------------------
main:
    la a0, str1
    li a1, 0            # a1 = left
    li a2, 4            # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str2
    li a1, 0            # a1 = left
    li a2, 2            # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str3
    li a1, 0            # a1 = left
    li a2, 29           # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str4
    li a1, 0            # a1 = left
    li a2, 7            # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str5
    li a1, 0            # a1 = left
    li a2, 38           # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str6
    li a1, 0            # a1 = left
    li a2, 0            # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

    la a0, str7
    li a1, 0            # a1 = left
    li a2, 2            # a2 = right
    jal ra, is_palindromo
    jal ra, print_result

   # Insira aqui o loop principal, ofereca ao usuario se ele deseja continuar ou não 

    # Encerrar
    li a7, 10          
    ecall

# O bloco main cria os testes, primeiro ele carrega o endereço da String, depois define o índice inicial e o final, chama a recursão e exibe o resultado. 
# TODO: falar sobre o loop aqui 
# A finalização define o código de encerramento e executa o chamado para encerrar o programa, também usa syscall 10, Exit.

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

# O bloco print_result exibe o resultado “SIM” ou “NAO”. Se o a0 for igual a zero, ele desvia para print_no, caso contrário, imprime “SIM”. Ambos utilizam a syscall 4, Print string, para imprimir e retornam à função chamadora.

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

# O bloco is_palindromo inicia a função recursiva e cria espaço na pilha salvando o contexto da função, guarda os registradores necessários e copia os parâmetros para registradores salvos.

skip_left:
    bge s1, s2, base_case
    add t0, s0, s1
    lbu t1, 0(t0)
    mv a0, t1
    jal ra, is_alnum_ascii
    beq a0, x0, inc_left
    j skip_right

# O bloco skip_left inicia o loop verificando se os índices se cruzam, calcula o endereço do caractere em left, carrega o caractere da memória e move para o registrador de argumento, chama a função de verificação de ASCII.
# Se não for alfanumérico, avança o índice da esquerda, senão, passa para o lado direito.

inc_left:
    addi s1, s1, 1
    j skip_left

# O bloco inc_left marca o ponto de incremento, somando 1 ao índice left e retornando ao início da verificação.

skip_right:
    bge s1, s2, base_case
    add t0, s0, s2
    lbu t1, 0(t0)
    mv a0, t1
    jal ra, is_alnum_ascii
    beq a0, x0, dec_right
    j compare_chars

# O bloco skip_right começa a verificação do lado direito e repete o processo do esquerdo, verificando se os índices se cruzam, lendo o caractere da posição right e testando se ele é alfanumérico e se não for, retrocede; se for, segue para a comparação.

dec_right:
    addi s2, s2, -1
    j skip_right

# O bloco dec_right retrocede o índice da direita, diminuindo 1, e volta para continuar o loop de verificação.

base_case:
    li a0, 1
    j end_pal

# O bloco base_case representa o caso de parada da recursão. Se os índices se cruzarem ou se igualarem, o texto é considerado palíndromo e retorna 1 (SIM).

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

# O bloco compare_chars faz a leitura e normalização dos caracteres das extremidades, convertendo ambos para minúsculas com to_lower_ascii e comparando.
# Se forem diferentes, retorna “NAO” e se forem iguais, avança os índices e chama recursivamente a função.

not_pal:
    li a0, 0

# O bloco not_pal define o retorno 0 (NAO) quando os caracteres das extremidades não são iguais.

end_pal:
    lw ra, 12(sp)
    lw s0, 8(sp)
    lw s1, 4(sp)
    lw s2, 0(sp)
    addi sp, sp, 16
    jr ra

# O bloco end_pal restaura o contexto salvo na pilha (registradores e endereço de retorno), libera o espaço da pilha e retorna o controle para a função chamadora.

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

# O bloco is_alnum_ascii verifica se o caractere informado está dentro das faixas ASCII de 0-9, A-Z ou a-z.
# Se estiver, retorna 1 (verdadeiro) e se não, retorna 0 (falso).

to_lower_ascii:
    li t0, 'A'
    li t1, 'Z'
    blt a0, t0, done_lower
    bgt a0, t1, done_lower
    addi a0, a0, 32
done_lower:
    jr ra

# O bloco to_lower_ascii converte letras maiúsculas (A-Z) para minúsculas (a-z) adicionando 32 ao código ASCII.
# Caso o caractere não esteja nesse intervalo, ele é retornado e não ocorrem alterações.