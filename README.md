# Calendario-em-Batch-File

___Objetivo___:  
Este script tem como objetivo calcular o número de dias em um mês específico de um ano, levando em consideração se o ano é bissexto ou não. Após calcular o número de dias, o script cria uma pasta para cada dia do mês dentro de uma estrutura de diretórios fornecida como entrada. O script resolve o problema de determinar a quantidade de dias de cada mês e gera uma organização de pastas representando cada dia.

___O que ele realiza___:
1. **Calcula o número de dias no mês**: O script verifica se o ano é bissexto e, com isso, define corretamente o número de dias para cada mês, levando em conta que fevereiro tem 29 dias nos anos bissextos e 28 dias nos outros anos.
2. **Cria diretórios**: Para cada dia do mês, o script cria uma pasta dentro da estrutura de diretórios especificada.
3. **Verifica se o ano é bissexto**: O script calcula se o ano é bissexto (ano divisível por 4, mas não por 100, ou divisível por 400) para ajustar o número de dias em fevereiro.

---

## Explicação Detalhada do Código

### 1. Verificação e Criação de Diretórios
```batch
if not exist "%1" (
    mkdir "%1"
)
cd "%1"

if not exist "%2" (
    mkdir "%2"
)
cd "%2"
```

---

Este bloco verifica se as pastas especificadas pelos parâmetros `%1` (primeiro diretório) e `%2` (segundo diretório) existem. Se não existirem, elas são criadas. O comando `cd` (change directory) move o script para dentro dessas pastas. Essas pastas vão ser usadas para armazenar os diretórios dos dias do mês.

### 2. Definição de Variáveis
Aqui, o script atribui os valores dos parâmetros fornecidos ao script para as variáveis mes (mês) e ano.

```batch
set mes=%3
set ano=%4
```
### 3. Cálculo do Ano Bissexto

```batch
set /a resto1=%ano% %% 4
set /a resto2=%ano% %% 100
set /a resto3=%ano% %% 400
set /a bissexto=0

if %resto1%==0 (
    if %resto2%==0 (
        if %resto3%==0 (
            set bissexto=1
        ) else (
            set bissexto=0
        )
    ) else (
        set bissexto=1
    )
)
```
- Este bloco calcula se o ano fornecido é bissexto ou não.
- O ano é bissexto se for divisível por 4, mas não por 100, ou se for divisível por 400.
- As variáveis resto1, resto2 e resto3 armazenam os restos das divisões do ano por 4, 100 e 400, respectivamente.
- A variável bissexto recebe o valor 1 (verdadeiro) se o ano for bissexto e 0 (falso) caso contrário.
---

### 4. Criação dos Diretórios para os Dias do Mês

- Usa um loop ```for /L```para criar pastas numeradas de 1 até o número de dias do mês.
```batch
echo O numero de dias no mes %mes% do ano %ano% é %dias%.

for /L %%i in (1,1,%dias%) do (
    mkdir %%i
)

cd ..
```
---

## Desafios e Soluções

- Lidar com anos bissextos: Foi necessário usar três condições para verificar corretamente se o ano é bissexto.
- Criação de diretórios automaticamente: O uso de mkdir dentro de um loop for /L permitiu criar pastas numeradas sem intervenção manual.
- Passagem de argumentos: O script depende de argumentos (%1 e %2), então, se não forem fornecidos corretamente, ele pode falhar.

## Aprendizado
 Com a construção deste codigo foi possivel compreender melhor sobre as cadeias de condições que, por sua vez, apresentavam uma logica visual simples porém de dificil aplicação e gerenciamento. Também foi possivel aprender conceitos importantes para a programação como variaveis, if e else, paremetros e loop

---

## Melhorias

### Validação dos argumentos  
Atualmente, o script assume que os argumentos fornecidos (`%1` para o ano e `%2` para o mês) são sempre valores numéricos válidos. No entanto, se o usuário inserir algo inválido (como letras ou um número fora do intervalo esperado), o script pode falhar ou gerar resultados inesperados.  
- **Solução:** Implementar verificações para garantir que o primeiro argumento seja um número de quatro dígitos (ex.: 2025) e que o segundo esteja entre 1 e 12. Caso contrário, exibir uma mensagem de erro e encerrar a execução.  

### Uso de `setlocal enabledelayedexpansion`  
Dentro de loops `for`, as variáveis padrão do Batch não são atualizadas dinamicamente. Isso pode causar comportamentos inesperados, especialmente ao trabalhar com números ou strings dentro do loop.  
- **Solução:** Adicionar `setlocal enabledelayedexpansion` no início do script e utilizar `!variavel!` em vez de `%variavel%` dentro dos loops para garantir a correta atualização dos valores.  

### Mensagens de erro mais amigáveis  
O script atualmente não fornece feedback claro quando o usuário insere valores inválidos. Um erro simples, como digitar "13" como mês, pode fazer o script criar diretórios inesperados.  
- **Solução:** Adicionar verificações com mensagens explicativas, como:  
  - "Erro: O mês deve estar entre 1 e 12."  
  - "Erro: O ano precisa ser um número válido de quatro dígitos."  
  - "Uso correto: script.bat [ano] [mês]"  

### Criação de logs  
Para monitorar a execução e verificar posteriormente quais pastas foram criadas, um sistema de log pode ser útil.  
- **Solução:** Registrar todas as ações do script em um arquivo `.log`, incluindo data, diretórios criados e possíveis erros. Isso ajuda a manter um histórico da execução e facilita a depuração caso algo não funcione como esperado.  
