# Trabalho de Fundamentos de Sistemas Computacionais (T2 de 2025/2)

**→ Sobre o projeto**
Este projeto implementa um verificador de palíndromos em Assembly RISC-V utilizando recursão. O programa realiza testes automáticos em strings predefinidas e permite ao usuário testar novas palavras ou frases. Durante a verificação: Caracteres não alfanuméricos são ignorados, a diferenças entre letras maiúsculas e minúsculas são ignoradas e as Strings vazias ou compostas apenas por caracteres não alfanuméricos são consideradas palíndromos. O projeto segue as convenções padrão de Assembly RISC-V 32 bits, preservando registradores em pilha, e utiliza syscalls para entrada e saída.
Recursão utilizada para percorrer os extremos da string comparando os caracteres de fora para dentro.

Syscalls usadas:
- 4 → imprimir string
- 8 → ler string do usuário
- 10 → encerrar programa
- Registradores preservados: s0, s1, s2, ra.
- Pilha utilizada para salvar o estado antes de chamadas recursivas.

**→ Estrutura do código**
bloco main:
- Executa os testes iniciais das strings predefinidas.
- Gerencia o loop interativo do usuário para testar novas strings.
- Encerra o programa com syscall 10.

bloco is_palindromo:
- Implementa a função recursiva que verifica se uma string é palíndromo.
- Ignora caracteres não alfanuméricos (is_alnum_ascii).
- Converte letras maiúsculas para minúsculas (to_lower_ascii).
- Retorna 1 se a string for palíndromo, 0 caso contrário.

bloco is_alnum_ascii:
- Verifica se um caractere é alfanumérico (0-9, A-Z, a-z).
- Retorna 1 se for alfanumérico, 0 se não.

bloco to_lower_ascii:
- Converte letras maiúsculas (A-Z) para minúsculas (a-z).
- Não altera números nem caracteres já em minúsculo.

bloco print_result:
- Exibe "SIM" ou "NAO" de acordo com o resultado retornado por is_palindromo.

bloco strlen_ascii:
- Calcula o comprimento da string, retornando o índice do último caractere válido.

**→ Exemplos de teste**
1. "radar" -> SIM
2. "Aba" -> SIM
3. "A man, a plan, a canal: Panama" → SIM
4. "123ab321" → NAO
5. "Socorram-me, subi no ônibus em Marrocos" → SIM
6. " " → SIM
7. "!!!" → SIM

**→ O arquivo .jar**
O arquivo rars1_6.jar é o RARS (RISC-V Assembler and Runtime Simulator). Este arquivo é o que permite que o código seja montado, executado, debugado e visualizado (memórias e registradores). Ele é essencial para o funcionamento do projeto.

**→ Como usar**
- Ter Java instalado (v8 ou superior)
- Ter o arquivo rars1_6.jar no diretório do projeto
- Ter o arquivo palindromo.s (código)
  
- Para executar, deve-se abrir o projeto na IDE de preferência e abrir o terminal, navegar para o diretório cd caminhoParaProjeto e executar o comando `java -jar rars1_6.jar palindromo.s`
- Após a execução, o programa vai exibir os resultados das strings de teste, perguntar se o usuário deseja continuar e repetir o processo.

**→ Integrantes**
- Carolina De Souza Gonçalves
- Lucas Arieta Pereira Da Silva
- Pedro Henrique de Oliveira Silveira
- Régis Augusto Martins Xavier Júnior
