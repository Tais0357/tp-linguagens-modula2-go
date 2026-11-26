# 5. Identificadores e Amarrações

## Visão Geral Comparativa

| Aspecto | Modula-2 | Go |
| :--- | :--- | :--- |
| **Sensibilidade a maiúsculas (*case-sensitivity*)** | Sim (`Total` ≠ `total`). Palavras reservadas são obrigatoriamente em **MAIÚSCULAS** | Sim (`Total` ≠ `total`). Palavras reservadas são obrigatoriamente em **minúsculas** |
| **Regras léxicas de identificadores** | Letra seguida de letras ou dígitos (PIM); o padrão ISO/IEC 10514-1 passou a permitir sublinhado (`_`) | Letra Unicode ou `_`, seguida de letras Unicode, dígitos ou `_` |
| **Semântica ligada à grafia** | Nenhuma (além da convenção visual das palavras reservadas em maiúsculas) | A **primeira letra maiúscula** define exportação (visibilidade pública fora do pacote) |
| **Declaração e definição** | Separadas em blocos rígidos (`CONST`, `TYPE`, `VAR`, `PROCEDURE`) antes do bloco `BEGIN` | Flexível: `var`, `const`, `type`, `func` podem aparecer junto ao ponto de uso dentro de funções |
| **Inferência de tipos** | Não suportada para variáveis (tipo sempre explícito); constantes têm tipo implícito pelo valor | Suportada via `var x = valor` ou declaração curta `x := valor` (dentro de funções) |
| **Amarração de tipo (*type binding*)** | Estática (em tempo de compilação) | Estática (em tempo de compilação), inclusive quando há inferência |
| **Amarração de armazenamento** | Estática (nível de módulo), pilha-dinâmica (locais) e *heap* explícita (`NEW`/`DISPOSE`) | Estática (nível de pacote) e automática via *escape analysis* (pilha ou *heap* gerenciada pelo GC) |

---

## Exemplo Comparativo de Código

### Modula-2 (`modula2/tipos/identificadores.mod`)
```modula2
MODULE Identificadores;

FROM InOut IMPORT WriteInt, WriteLn;

CONST
  Limite = 10; (* Amarração de valor em tempo de compilação *)

VAR
  contador: INTEGER; (* Tipo obrigatoriamente explícito *)

BEGIN
  contador := Limite + 5;
  WriteInt(contador, 0);
  WriteLn;
END Identificadores.
```

### Go (`go/tipos/identificadores.go`)
```go
package main

import "fmt"

const Limite = 10 // Constante exportável (maiúscula) e sem tipo fixo inicial

func main() {
	var contador int = Limite + 5 // Declaração explícita
	dobro := contador * 2         // Inferência de tipo (amarração estática para int)

	fmt.Println(contador, dobro)
}
```

---

## Análise Comparativa e Decisões de Projeto

### 1. Regras de Identificadores e Semântica Visual
* **Mecanismo:** Ambas são *case-sensitive*, mas usam a capitalização de formas muito diferentes. Modula-2 exige palavras reservadas em maiúsculas (`MODULE`, `VAR`, `BEGIN`), separando visualmente a estrutura da linguagem dos identificadores do programador. Go usa a capitalização do próprio identificador para controlar encapsulamento: nomes iniciados com letra maiúscula são exportados do pacote; minúsculos são privados.
* **Decisão de projeto:** Wirth priorizou o contraste visual imediato na leitura de código sem depender de editores com *syntax highlighting* (comuns apenas décadas depois). Go eliminou palavras-chave extras como `public` e `private` para manter a sintaxe enxuta e tornar a visibilidade legível diretamente no ponto de uso.
* **Vantagem / Desvantagem / Trade-off:** Em Modula-2, a leitura estrutural é muito clara, mas digitar palavras reservadas em maiúsculas reduz a **redigibilidade**. Em Go, a regra de capitalização melhora a **legibilidade** e reduz ruído sintático, mas limita a liberdade de nomeação e pode causar surpresas para iniciantes (além de exigir renomear identificadores em todo o pacote caso a visibilidade mude).

### 2. Declarações Explícitas vs. Inferência de Tipos
* **Mecanismo:** Modula-2 obriga a declarar todas as variáveis em uma seção `VAR` dedicada antes do código executável, sempre com tipo explícito. Go permite declarar variáveis próximas ao ponto de uso e oferece inferência local com `:=`, mantendo a amarração de tipo **estática** (o compilador deduz o tipo uma única vez e ele não muda em tempo de execução).
* **Decisão de projeto:** A separação em blocos de Modula-2 facilitava compiladores de passagem única com pouca memória, pois o compilador conhecia toda a tabela de símbolos antes de analisar as instruções. Go priorizou a ergonomia moderna, reduzindo repetição desnecessária sem abrir mão da segurança de tipos estática.
* **Vantagem / Desvantagem / Trade-off:** Modula-2 oferece um "índice" imediato de todas as variáveis no topo de cada módulo ou procedimento, mas distancia a declaração do uso em funções longas (prejudicando a **modificabilidade**). Go ganha em **redigibilidade** e localidade do código, embora o uso excessivo de `:=` em expressões complexas possa obscurecer o tipo exato para quem lê o código fora de uma IDE.

### 3. Amarrações de Armazenamento (*Storage Binding*)
* **Mecanismo:** Em Modula-2, o tempo de vida e o local de armazenamento são decididos explicitamente pelo programador: variáveis de módulo são estáticas, variáveis locais ficam na pilha e alocações dinâmicas na *heap* exigem chamadas manuais (`NEW`/`DISPOSE`). Em Go, o programador não escolhe diretamente pilha ou *heap*: o compilador executa *escape analysis* para decidir se uma variável pode ficar na pilha ou se "escapa" para a *heap* (sendo depois liberada pelo *Garbage Collector*).
* **Decisão de projeto:** Modula-2 foi desenhada para previsibilidade de memória em sistemas de baixo nível; Go abstrai o local de alocação para evitar *dangling pointers* (como retornar o ponteiro de uma variável local, que é inválido em C/Modula-2, mas perfeitamente seguro em Go).
* **Vantagem / Desvantagem / Trade-off:** Modula-2 garante controle total e **eficiência** previsível, mas transfere o risco de vazamentos e ponteiros inválidos ao programador. Go eleva drasticamente a **confiabilidade**, ao custo de menor controle direto sobre quando ocorrem alocações na *heap*.
