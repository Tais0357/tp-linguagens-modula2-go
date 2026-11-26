# 2. Paradigmas

## Visão Geral Comparativa

| Aspecto | Modula-2 | Go |
| :--- | :--- | :--- |
| **Paradigma predominante** | Imperativo, estruturado e modular | Imperativo, estruturado e concorrente (CSP) |
| **Natureza multiparadigma** | Restrita (foco estrito em procedural/modular, com suporte de baixo nível a corrotinas) | Moderada (procedural + concorrência nativa + elementos funcionais + composição com interfaces) |
| **Orientação a Objetos (POO)** | Não suporta (sem classes, herança ou polimorfismo de subtipo) | Não segue POO clássica (sem classes/herança); usa `structs`, métodos e interfaces estruturais |
| **Concorrência** | Primitivas de baixo nível via módulo `SYSTEM` (corrotinas cooperativas com `TRANSFER`) | Cidadã de primeira classe no *runtime* (*goroutines* e *channels* baseados em CSP) |
| **Elementos funcionais** | Limitados (tipos `PROCEDURE` como ponteiros de função, sem *closures*) | Funções de primeira classe, funções anônimas e *closures* |

---

## Análise Comparativa e Decisões de Projeto

### 1. Base Imperativa e Rejeição à Complexidade (A Raiz Comum)
* **Mecanismo:** Tanto Modula-2 quanto Go têm como núcleo o paradigma **imperativo e estruturado**, baseado em mutação explícita de estado, laços e subprogramas. Nenhuma das duas adota o modelo clássico de Orientação a Objetos com hierarquias de classes e herança.
* **Decisão de projeto:** Modula-2 foi criada por Niklaus Wirth em 1978, antes da consolidação da POO no *mainstream*, priorizando a **programação modular** (separação entre interface e implementação) para organizar sistemas grandes e software básico. Já Go (2009) rejeitou deliberadamente a herança de classes para evitar hierarquias rígidas e complexidade acidental, adotando **composição sobre herança** e interfaces implícitas.
* **Vantagem / Desvantagem / Trade-off:** Ambas ganham em **legibilidade**, **facilidade de aprendizado** e **previsibilidade** (o fluxo de execução é direto). Em contrapartida, perdem em expressividade para domínios que se beneficiam naturalmente de hierarquias de tipos ricas ou programação funcional pura, exigindo código mais explícito (menor **redigibilidade** em abstrações complexas).

### 2. Concorrência: Controle Manual vs. Abstração de Alto Nível
* **Mecanismo:** Modula-2 trata concorrência como uma extensão de baixo nível via corrotinas (`NEWPROCESS` e `TRANSFER` no módulo `SYSTEM`), permitindo ao programador construir seu próprio escalonador. Go eleva a concorrência a um paradigma central, inspirado em *Communicating Sequential Processes* (CSP), usando *goroutines* leves e *channels*.
* **Decisão de projeto:** Nos anos 1970/80, o hardware era predominantemente *single-core* e Modula-2 visava sistemas operacionais e embarcados, onde o controle total sobre o escalonamento era essencial. Em 2009, com processadores *multicore* e sistemas distribuídos em rede, Go decidiu embutir um escalonador cooperativo/preemptivo (M:N) no *runtime*.
* **Vantagem / Desvantagem / Trade-off:** Modula-2 oferece **eficiência** e determinismo absoluto sem sobrecarga de *runtime*, mas transfere toda a complexidade e risco de erro para o programador (menor **confiabilidade** e **produtividade** em código concorrente). Go oferece altíssima **produtividade** e segurança relativa na comunicação entre tarefas, ao custo de um *runtime* mais pesado e menor controle fino sobre o hardware.

### 3. Natureza Multiparadigma e Funções como Valores
* **Mecanismo:** Modula-2 é propositalmente monoparadigma (imperativo/modular), oferecendo apenas variáveis de tipo `PROCEDURE` (equivalentes a ponteiros de função, sem captura de ambiente). Go, embora não seja uma linguagem funcional, incorpora funções de primeira classe e *closures*, combinando estilo procedural com padrões funcionais pontuais (como *callbacks*, *middleware* e `defer`).
* **Decisão de projeto:** Wirth priorizou uma especificação mínima e um compilador simples de implementar em máquinas com pouca memória. Go equilibra simplicidade sintática com ergonomia moderna para desenvolvimento de serviços e APIs.
* **Vantagem / Desvantagem / Trade-off:** A abordagem de Modula-2 maximiza a **simplicidade do compilador** e evita custos ocultos de alocação na *heap* (já que não há *closures* capturando variáveis). Go ganha em **reusabilidade** e **modificabilidade**, mas *closures* podem causar escape de variáveis para a *heap*, aumentando a pressão sobre o *Garbage Collector*.
