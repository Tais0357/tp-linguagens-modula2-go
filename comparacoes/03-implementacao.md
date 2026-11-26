# 3. Implementação

## Visão Geral Comparativa

| Aspecto | Modula-2 | Go |
| :--- | :--- | :--- |
| **Estratégia predominante** | Compilação antecipada (*Ahead-of-Time* — AOT) para código nativo (historicamente também *bytecode* M-code) | Compilação antecipada (*Ahead-of-Time* — AOT) para código nativo |
| **Implementação principal / de referência** | Historicamente o compilador da ETH Zürich (M-code para Lilith); atualmente **GNU Modula-2 (`gm2`)**, integrado ao GCC | **`gc`** (compilador oficial da toolchain Go, escrito na própria linguagem Go) |
| **Outras implementações relevantes** | **XDS Modula-2** (nativo e transpilador para C), **MOCKA**, **ADW Modula-2**, **p1 Modula-2** | **`gccgo`** (frontend do GCC), **`TinyGo`** (baseado em LLVM para embarcados/Wasm), **`Yaegi`** (interpretador) |
| **Uso de *bytecode* ou JIT** | Usou *bytecode* (**M-code**) na estação Lilith (executado diretamente em microcódigo); implementações modernas não usam JIT | Não utiliza *bytecode* nem JIT na implementação padrão (`gc`) |
| **Ligação e *runtime*** | Binários enxutos com *runtime* mínimo (sem *Garbage Collector* obrigatório) | Binários geralmente ligados estaticamente, embutindo o *runtime* de Go (GC + escalonador de *goroutines*) |

---

## Análise Comparativa e Decisões de Projeto

### 1. Diferença entre Linguagem e Implementação
* **Mecanismo:** É comum classificar tanto Modula-2 quanto Go como "linguagens compiladas", mas **a forma de execução é uma propriedade da implementação, não da linguagem**. A especificação de uma linguagem define sintaxe e semântica; já compiladores, interpretadores e máquinas virtuais são ferramentas que a executam.
* **Na prática:**
  * **Modula-2** nasceu gerando *bytecode* compacto (**M-code**) projetado para o microcódigo do computador Lilith, mas evoluiu para compiladores nativos tradicionais (como `gm2` no GCC) e até transpiladores para C (como o XDS-C).
  * **Go** tem como padrão o compilador nativo `gc`, mas possui implementações alternativas com objetivos distintos: `gccgo` (otimizações do GCC), `TinyGo` (foco em microcontroladores e WebAssembly via LLVM) e `Yaegi` (um interpretador usado para scripts e plugins em tempo de execução).
* **Trade-off:** Separar a especificação da implementação aumenta a **portabilidade** e a longevidade da linguagem, permitindo adaptá-la a novos hardwares (como o `TinyGo` faz para sistemas embarcados) sem alterar a linguagem em si.

### 2. Projeto Voltado para Compilação Rápida
* **Mecanismo:** Ambas as linguagens foram projetadas desde a gramática para permitir compilação extremamente rápida. Modula-2 foi desenhada por Wirth para ser compilada em poucas passagens (ou até passagem única, em versões posteriores) usando arquivos de símbolos pré-compilados gerados a partir dos `DEFINITION MODULE`. Go elimina arquivos de cabeçalho, proíbe dependências circulares entre pacotes e lê apenas os dados de exportação dos pacotes diretamente importados.
* **Decisão de projeto:** Em 1978, a compilação rápida era necessária porque os computadores tinham pouquíssima memória e CPU lenta. Em 2009, no Google, o problema era o tamanho gigantesco das bases de código em C++, que levavam minutos ou horas para compilar.
* **Vantagem / Desvantagem / Trade-off:** Ganha-se enorme **produtividade** no ciclo de desenvolvimento (editar → compilar → testar quase instantâneo) e compiladores mais simples de manter. Em contrapartida, o compilador `gc` de Go historicamente abre mão de algumas otimizações agressivas de código (como as feitas por C++/LLVM) para manter o tempo de compilação baixo, o que pode gerar uma leve perda de **eficiência** máxima em código intensivo de CPU.

### 3. Binários Nativos vs. Sobrecarga de *Runtime*
* **Mecanismo:** Compiladores modernos de Modula-2 (como `gm2`) geram código de máquina direto com dependência mínima de *runtime*, aproximando-se do modelo de C. Já o compilador `gc` de Go gera executáveis nativos autocontidos (tipicamente sem dependências externas de bibliotecas dinâmicas), mas que carregam internamente todo o *runtime* de Go (coletor de lixo, escalonador de *goroutines* e reflexão).
* **Decisão de projeto:** Modula-2 priorizou eficiência máxima e controle próximo ao hardware para sistemas operacionais e embarcados. Go priorizou facilidade de implantação (*deploy* de um único binário em servidores e contêineres) e concorrência nativa.
* **Vantagem / Desvantagem / Trade-off:** Modula-2 produz binários muito menores e com comportamento determinístico (alta **eficiência** de memória e previsibilidade). Go gera binários maiores (um simples "Hello World" passa de 1 MB), mas oferece altíssima **portabilidade** de distribuição e *cross-compilation* trivial (basta definir `GOOS` e `GOARCH`).
