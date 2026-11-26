# 4. Propriedades Desejáveis

## Visão Geral Comparativa

| Propriedade | Modula-2 | Go |
| :--- | :--- | :--- |
| **Legibilidade** | Alta: palavras-chave explícitas em maiúsculas (`BEGIN`, `END`, `IF ... THEN`) e separação rígida entre interface e implementação | Muito alta: sintaxe minimalista (apenas 25 palavras-chave), formatação padronizada (`gofmt`) e poucas formas de fazer a mesma coisa |
| **Confiabilidade** | Alta em tipagem (estática e forte, sem coerções implícitas), mas vulnerável a erros de memória manual (`NEW`/`DISPOSE`) e acesso via `SYSTEM` | Muito alta: tipagem estática forte, *Garbage Collector*, verificação de limites de *slices/arrays* e tratamento explícito de erros |
| **Eficiência** | Muito alta: código nativo direto, sem *Garbage Collector* e com controle fino de memória e hardware | Alta: código nativo compilado, mas com leve sobrecarga de CPU/memória devido ao *runtime* (GC e escalonador) |
| **Portabilidade** | Moderada/Baixa: fragmentação histórica entre dialetos (PIM2/3/4 vs ISO) e ausência de biblioteca padrão unificada no início | Muito alta: especificação única, biblioteca padrão rica e *cross-compilation* nativa trivial (`GOOS`/`GOARCH`) |

---

## Análise Comparativa e Decisões de Projeto

### 1. Legibilidade
* **Mecanismo:** Modula-2 exige palavras-chave reservadas em letras maiúsculas (`PROCEDURE`, `WHILE`, `END`) e obriga a declaração prévia de variáveis e módulos de definição (`DEFINITION MODULE`), separando claramente o "o quê" do "como". Go adota sintaxe inspirada em C, mas drasticamente simplificada (25 palavras-chave), elimina parênteses obrigatórios em `if`/`for` e impõe um estilo visual único por meio da ferramenta oficial `gofmt`.
* **Decisão de projeto:** Wirth acreditava que o código é lido muito mais vezes do que escrito; a obrigatoriedade de maiúsculas nas palavras-chave destaca imediatamente a estrutura de controle do algoritmo. Os criadores de Go levaram a legibilidade para o nível de engenharia em grandes equipes, eliminando debates de estilo e construções sintáticas obscuras.
* **Vantagem / Desvantagem / Trade-off:** Ambas entregam excelente **legibilidade** e **modificabilidade**. Em Modula-2, a verbosidade e o uso constante de maiúsculas reduzem a **redigibilidade** (escreve-se mais para tarefas simples). Em Go, a simplicidade extrema evita "mágica" no código, mas pode gerar repetição (como `if err != nil`), também sacrificando parte da concisão em favor da clareza.

### 2. Confiabilidade
* **Mecanismo:** Ambas possuem tipagem estática forte e proíbem conversões implícitas entre tipos numéricos diferentes (como somar `INTEGER` com `REAL` em Modula-2, ou `int` com `float64` em Go). A grande diferença está na memória: Modula-2 usa alocação manual (`NEW`/`DISPOSE`) e permite burlar o sistema de tipos via módulo `SYSTEM` (`CAST`, `ADDRESS`). Go usa *Garbage Collector*, proíbe aritmética de ponteiros (fora do pacote `unsafe`) e inicializa automaticamente toda variável com seu *zero value*.
* **Decisão de projeto:** Modula-2 precisava escrever sistemas operacionais e drivers, exigindo uma "porta de saída" controlada (`SYSTEM`) para acessar endereços físicos. Go foi projetada para servidores conectados à internet, onde falhas de memória (*use-after-free*, *dangling pointers*) representam riscos graves de segurança e estabilidade.
* **Vantagem / Desvantagem / Trade-off:** Go alcança maior **confiabilidade** e segurança de memória por padrão, eliminando classes inteiras de bugs. Modula-2 transfere essa responsabilidade para o programador: perde em segurança automática, mas ganha previsibilidade e capacidade de atuar diretamente no nível de hardware.

### 3. Eficiência
* **Mecanismo:** Modula-2 compila para código de máquina enxuto sem *runtime* pesado, com alocação determinística na pilha e gestão manual na *heap*. Go também compila para código nativo eficiente, mas todo executável embute um *runtime* com *Garbage Collector* concorrente e escalonador de *goroutines*.
* **Decisão de projeto:** No final dos anos 1970, cada kilobyte de RAM e ciclo de CPU era crítico. Em 2009, a abundância de memória e núcleos de CPU permitiu trocar uma pequena fração de desempenho bruto por produtividade, concorrência escalável e segurança.
* **Vantagem / Desvantagem / Trade-off:** Modula-2 leva vantagem em **eficiência de memória**, tamanho de binário e previsibilidade de latência (sem pausas de GC), sendo mais adequada a sistemas de tempo real restrito. Go perde um pouco nesse controle fino, mas compensa com altíssima **eficiência em sistemas concorrentes e de I/O**, aproveitando múltiplos núcleos de forma quase transparente.

### 4. Portabilidade
* **Mecanismo:** Modula-2 sofreu historicamente com múltiplos dialetos (as diferentes edições do livro *Programming in Modula-2* de Wirth e, apenas em 1996, o padrão ISO/IEC 10514-1), além de bibliotecas de entrada/saída (`InOut`, `STextIO`) que variavam entre compiladores. Go nasceu com uma especificação única, biblioteca padrão abrangente e suporte embutido a compilação cruzada (*cross-compilation*).
* **Decisão de projeto:** Modula-2 manteve a linguagem mínima e deixou bibliotecas de I/O fora do núcleo da linguagem, delegando-as a módulos externos. Go adotou a filosofia de "baterias incluídas" e promessa de compatibilidade retroativa (Go 1).
* **Vantagem / Desvantagem / Trade-off:** A decisão de Modula-2 manteve o núcleo da linguagem minúsculo e independente de sistema operacional, mas prejudicou severamente a **portabilidade** prática entre compiladores. Go maximiza a **portabilidade** e a **reusabilidade** de código entre Linux, Windows e macOS, ao custo de manter uma biblioteca padrão extensa e um *runtime* específico para cada sistema alvo.
