# Estudo Comparativo de Linguagens de Programação: Modula-2 vs Go

Trabalho Prático desenvolvido para a disciplina **Linguagens de Programação** (Ciência da Computação — Universidade Federal de Viçosa, Campus Florestal), ministrada pelo Prof. Lucas Bragança da Silva.

---

## 1. Identificação
* **Integrantes:**
  * Taís Aparecida da Silva Ribeiro
  * Tatiana Geralda da Silva Ribeiro
  * Fabrício Henrique Viana Albino
  * Rafael Resende Soares
* **Linguagem Histórica:** Modula-2
* **Linguagem Contemporânea:** Go

---

## 2. Motivação
A escolha do par **Modula-2** e **Go** permite analisar uma linhagem direta na história das linguagens de programação. Criada por Niklaus Wirth no final dos anos 1970, Modula-2 consolidou princípios de simplicidade, compilação eficiente e modularização rigorosa. Três décadas depois, Go (2009) — projetada por Robert Griesemer (ex-aluno de Wirth), Rob Pike e Ken Thompson — resgatou essa filosofia de minimalismo e engenharia de software, mas adaptada aos desafios modernos de hardware *multicore*, redes e gerenciamento automático de memória.

---

## 3. Contexto Histórico
*(Resumo breve do Tópico 1 — o detalhamento completo está em [1. Contexto histórico](comparacoes/01-contexto-historico.md).)*

* **Modula-2 (1978):** Projetada por Niklaus Wirth na ETH Zürich como sucessora de Pascal e Modula, com foco em programação de sistemas e desenvolvimento modular de software.
* **Go (2009):** Desenvolvida no Google para atender à construção de sistemas distribuídos e infraestrutura de larga escala, priorizando compilação rápida, simplicidade e concorrência nativa.

---

## 4. Ambiente e Reprodutibilidade
*(Atualizar com as versões exatas assim que os primeiros exemplos de código forem testados.)*

* **Sistema Operacional:** *(a definir)*
* **Modula-2:** GNU Modula-2 (`gm2`) — versão *(a definir)*
* **Go:** Go Toolchain (`go`) — versão *(a definir)*

---

## 5. Como Compilar e Executar

### Modula-2
```bash
gm2 -o programa modula2/<pasta>/<arquivo>.mod
./programa
```

### Go
```bash
go run go/<pasta>/<arquivo>.go
```

---

## 6. Análise dos Tópicos Obrigatórios

### Bloco 1 — Fundamentos
* [x] [1. Contexto histórico](comparacoes/01-contexto-historico.md)
* [x] [2. Paradigmas](comparacoes/02-paradigmas.md)
* [x] [3. Implementação](comparacoes/03-implementacao.md)
* [x] [4. Propriedades desejáveis](comparacoes/04-propriedades-desejaveis.md)
* [x] [5. Identificadores e amarrações](comparacoes/05-identificadores-amarracoes.md)
* [x] [6. Escopo](comparacoes/06-escopo.md)

### Bloco 2 — Dados e Memória
* [x] [7. Tipos primitivos](comparacoes/07-tipos-primitivos.md)
* [ ] 8. Representação dos tipos
* [ ] 9. Tipos compostos
* [ ] 10. Strings
* [ ] 11. Ponteiros e referências
* [ ] 12. Variáveis e constantes
* [ ] 13. Gerenciamento de memória

### Bloco 3 — Controle e Subprogramas
* [ ] 14. Expressões
* [ ] 15. Comandos
* [ ] 16. Expressões x comandos
* [ ] 17. Subprogramas
* [ ] 18. Parâmetros
* [ ] 19. Passagem de parâmetros
* [ ] 20. Funções como valores

### Bloco 4 — Abstração e Modularização
* [ ] 21. Abstração
* [ ] 22. TADs (Tipos Abstratos de Dados)
* [ ] 23. Encapsulamento
* [ ] 24. Modularização
* [ ] 25. Compilação separada

### Bloco 5 — Recursos Avançados e Erros
* [ ] 26. Polimorfismo
* [ ] 27. Programação genérica
* [ ] 28. Sobrecarga
* [ ] 29. Tratamento de exceções

---

## 7. Síntese Comparativa e Comparação Histórica
*(Em construção — serão consolidadas aqui a tabela comparativa geral e a análise aprofundada de pelo menos três diferenças históricas e seus trade-offs.)*

---

## 8. Conclusão
*(Em construção — responderá às três questões obrigatórias:)*
1. **Quais decisões de projeto de Modula-2 ainda são interessantes atualmente?**
2. **Quais problemas ou limitações são tratados de maneira diferente em Go?**
3. **Em uma nova linguagem para domínio semelhante, quais características de cada uma preservaríamos e por quê?**

---

## 9. Referências
A lista completa de especificações, livros e documentações oficiais utilizadas está disponível em [docs/referencias.md](docs/referencias.md).

---

## 10. Uso de Inteligência Artificial
Neste trabalho, foram utilizadas ferramentas de Inteligência Artificial generativa (como Gemini) para apoio na organização do repositório, estruturação inicial das comparações, revisão de escrita e elaboração preliminar de exemplos. Todas as afirmações técnicas e códigos foram revisados e verificados pelo grupo em fontes oficiais e documentações das linguagens.
