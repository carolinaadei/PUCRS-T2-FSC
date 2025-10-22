# Trabalho de Fundamentos de Sistemas Computacionais (T2 de 2025/2)

**→ Sobre o projeto**
Este projeto implementa um verificador de palíndromos em Assembly RISC-V utilizando recursão. O programa cria verificações de strings de teste e permite ao usuário testar novas palavras. Na leitura das palavras, os caracteres não alfanuméricos e as diferenças entre letras maiúsculas e minúsculas são ignorados. Quando a string está vazia, ele a retorna como palíndromo. O projeto também implementa Assembly RISC-V em 32 bits, utiliza as convenções padrão de RISC-V, preserva os registradores em pilha e usa 3 tipos de syscall (4 para imprimir string, 8 para ler string e 10 para encerrar o programa).

**→ Estrutura do código**
bloco main: Executa os testes e gerencia o loop de novas strings do usuário
bloco is_palindromo: Cria a função recursiva de verificação da string
bloco is_alnum_ascii: Verifica se o caractere é alfanumérico para poder testá-lo
bloco to_lower_ascii: Converte as letras maiúsculas para minúsculas
bloco print_result: Exibe "SIM" ou "NAO" conforme o resultado

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
