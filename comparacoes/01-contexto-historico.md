# 1. Contexto Histórico

## Visão Geral Comparativa

| Aspecto | Modula-2 | Go |
| :--- | :--- | :--- |
| **Período de criação** | 1978–1980 (primeira implementação em 1979; publicação formal em 1980) | 2007–2009 (anunciada em novembro de 2009; versão 1.0 em 2012) |
| **Origem / Instituição** | ETH Zürich (Instituto Federal de Tecnologia de Zurique), Suíça | Google, Estados Unidos |
| **Projetistas** | Niklaus Wirth | Robert Griesemer, Rob Pike e Ken Thompson |
| **Precursoras / Influências** | Pascal, Modula (1975) e Mesa | C, Pascal, Modula-2, Oberon, Newsqueak e CSP |
| **Domínio de aplicação** | Programação de sistemas, sistemas operacionais (estação Lilith), embarcados e ensino de engenharia de software | Sistemas distribuídos, infraestrutura em nuvem (*cloud*), serviços de rede, microsserviços e ferramentas de CLI |

---

## Análise Comparativa e Decisões de Projeto

### 1. O Problema que Cada Linguagem Veio Resolver
* **Modula-2:** No final da década de 1970, Pascal havia se tornado um sucesso no ensino, mas apresentava limitações sérias para programação de sistemas reais: não possuía compilação separada padrão, módulos de encapsulamento nem acesso controlado a recursos de baixo nível. Niklaus Wirth projetou Modula-2 enquanto desenvolvia o computador pessoal **Lilith** na ETH Zürich, buscando uma única linguagem capaz de escrever desde o sistema operacional e drivers até aplicações de alto nível.
* **Go:** No final dos anos 2000, o Google enfrentava gargalos severos no desenvolvimento de software em larga escala com C++ e Java: tempos de compilação extremamente longos, complexidade crescente das linguagens, dificuldade para gerenciar dependências e modelos de concorrência custosos em servidores *multicore*. Go nasceu para unir a eficiência de compilação e execução de linguagens estaticamente tipadas à produtividade de linguagens dinâmicas.
* **Decisão de projeto e trade-off:** Ambas surgiram como reação à complexidade excessiva ou às limitações práticas das ferramentas de sua época. A escolha por **simplicidade e compilação rápida** trouxe ganhos diretos em **legibilidade**, **facilidade de aprendizado** e **produtividade**, mas ao custo de deixar de fora recursos avançados de abstração que outras linguagens concorrentes (como Ada na época do Modula-2, ou Rust/C++ modernos na época do Go) oferecem.

### 2. A Linhagem Wirthiana e a Evolução do Hardware
* **Conexão histórica:** Existe uma ponte direta entre as duas linguagens. **Robert Griesemer**, um dos três criadores de Go, foi aluno de doutorado de Niklaus Wirth na ETH Zürich e trabalhou com linguagens da família Pascal/Modula-2/Oberon. Isso explica por que Go herda decisões típicas dessa linhagem — como a ordem das declarações (`nome tipo`), a ausência de conversões implícitas entre tipos numéricos e o foco em uma gramática enxuta.
* **Impacto do contexto de hardware:** Modula-2 foi projetada para máquinas *single-core* com memória extremamente limitada (o Lilith tinha 128 KB de RAM), o que exigia gerenciamento manual de memória e controle direto sobre o hardware. Go surgiu na era dos processadores *multicore*, redes de alta velocidade e servidores com gigabytes de RAM, justificando a inclusão de um *Garbage Collector* e um *runtime* com escalonador de concorrência embutido.
* **Trade-off:** Modula-2 entrega **previsibilidade** e **baixo custo de abstração** (ideal para hardware restrito), enquanto Go prioriza **segurança de memória** e **escalabilidade em sistemas concorrentes**, aceitando a sobrecarga de memória e CPU do seu *runtime*.

### 3. Padronização e Evolução do Ecossistema
* **Modula-2:** Teve múltiplas variações entre implementações (como PIM2, PIM3, PIM4 e, bem mais tarde, o padrão ISO/IEC 10514-1 em 1996). A fragmentação de bibliotecas padrão e a ascensão comercial de C e C++ reduziram sua adoção fora de nichos acadêmicos e embarcados.
* **Go:** Nasceu com forte controle de compatibilidade (*Go 1 Compatibility Promise*), biblioteca padrão abrangente (incluindo HTTP, criptografia e JSON) e ferramental unificado (`go fmt`, `go test`, `go mod`), impulsionando sua adoção massiva em projetos como Docker e Kubernetes.
* **Trade-off:** O ecossistema centralizado e padronizado de Go maximiza a **portabilidade** e a **manutenibilidade** entre equipes grandes, enquanto a descentralização histórica de Modula-2 dificultou a portabilidade de código entre diferentes compiladores.
