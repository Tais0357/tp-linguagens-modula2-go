# 6. Escopo

## Visão Geral Comparativa

| Aspecto | Modula-2 | Go |
| :--- | :--- | :--- |
| **Tipo de escopo** | Estático (léxico) | Estático (léxico) |
| **Níveis de escopo** | Módulo (global ao módulo), módulos locais (`MODULE` aninhado) e procedimentos (`PROCEDURE`) | Universo (*predeclared*), pacote (*package*), arquivo (para `import`), função e blocos de comando (`if`, `for`, `{}`) |
| **Escopo de bloco em comandos** | Não possui (todas as variáveis locais pertencem ao `PROCEDURE` ou `MODULE`) | Sim (variáveis declaradas em `if`, `for`, `switch` ou `{}` existem apenas naquele bloco) |
| **Subprogramas aninhados** | Sim (`PROCEDURE` dentro de `PROCEDURE`, com acesso léxico às variáveis externas) | Não para funções nomeadas, mas permite funções anônimas (*closures*) dentro de funções |
| **Sombreamento (*shadowing*)** | Permitido em escopos internos (ex.: variável local com mesmo nome de uma variável de módulo) | Permitido em blocos internos (muito comum ocorrer acidentalmente com `:=`) |

---

## Demonstração Prática por Meio de Código

Os exemplos abaixo demonstram o **escopo estático (léxico)** e o **sombreamento (*shadowing*)** nas duas linguagens, além da diferença estrutural: procedimentos aninhados em Modula-2 versus blocos e *closures* em Go.

### Modula-2 (`modula2/escopo/escopo.mod`)
```modula2
MODULE Escopo;

FROM InOut IMPORT WriteInt, WriteString, WriteLn;

VAR
  x: INTEGER; (* Escopo de módulo *)

PROCEDURE MostrarGlobal;
BEGIN
  (* Por ser escopo estático, acessa o 'x' do módulo, não o de quem chamou *)
  WriteString("Em MostrarGlobal, x = ");
  WriteInt(x, 0);
  WriteLn;
END MostrarGlobal;

PROCEDURE Externa;
VAR
  x: INTEGER; (* Sombreamento: oculta o 'x' do módulo dentro de Externa *)

  PROCEDURE Interna;
  BEGIN
    (* Acessa o 'x' do escopo léxico imediatamente envolvente (Externa) *)
    WriteString("Em Interna, x = ");
    WriteInt(x, 0);
    WriteLn;
  END Interna;

BEGIN
  x := 20;
  Interna;       (* Imprime 20 *)
  MostrarGlobal; (* Imprime 10, comprovando escopo estático *)
END Externa;

BEGIN
  x := 10;
  Externa;
  WriteString("No modulo principal, x = ");
  WriteInt(x, 0); (* Imprime 10 *)
  WriteLn;
END Escopo.
```

### Go (`go/escopo/main.go`)
```go
package main

import "fmt"

var x = 10 // Escopo de pacote

func mostrarGlobal() {
	// Escopo estático: sempre enxerga o 'x' do pacote
	fmt.Println("Em mostrarGlobal, x =", x)
}

func externa() {
	x := 20 // Sombreamento: cria um novo 'x' local à função externa

	// Go não tem funções nomeadas aninhadas, mas usa closures com escopo léxico
	interna := func() {
		fmt.Println("Em interna (closure), x =", x)
	}

	interna()       // Imprime 20
	mostrarGlobal() // Imprime 10, comprovando escopo estático

	// Escopo de bloco (não existe em Modula-2)
	if x := 30; x > 0 {
		fmt.Println("Dentro do bloco if, x =", x) // Imprime 30
	}

	fmt.Println("Apos o bloco if, x =", x) // Volta a imprimir 20
}

func main() {
	externa()
	fmt.Println("Em main, x =", x) // Imprime 10
}
```

**Saída esperada (comportamento equivalente de escopo estático):**
* Em ambos os programas, `MostrarGlobal` / `mostrarGlobal` imprime `10`, mesmo sendo chamada dentro de `Externa` / `externa` onde `x` vale `20`. Isso comprova que a resolução de nomes ocorre pela **estrutura léxica do código** (estática), e não pela pilha de chamadas (dinâmica).

---

## Análise Comparativa e Decisões de Projeto

### 1. Escopo Estático como Base Comum
* **Mecanismo:** Ambas adotam exclusivamente **escopo estático (léxico)**: o significado de qualquer identificador é determinado em tempo de compilação pela posição textual da declaração.
* **Decisão de projeto:** O escopo dinâmico dificulta a leitura, impede otimizações de compilação e quebra o encapsulamento. Tanto Wirth quanto os criadores de Go priorizaram previsibilidade e verificação estática.
* **Vantagem / Desvantagem / Trade-off:** Garante alta **legibilidade**, **confiabilidade** e **eficiência** (endereços e deslocamentos resolvidos em compilação), sem desvantagens práticas relevantes para programação de sistemas.

### 2. Procedimentos/Módulos Aninhados vs. Escopo de Bloco
* **Mecanismo:** Modula-2 permite aninhar procedimentos (`PROCEDURE`) e até **módulos locais** (`MODULE` com listas explícitas de `IMPORT`/`EXPORT`) dentro de outro módulo, mas não permite declarar variáveis restritas a um `IF` ou `WHILE`. Go faz o oposto: não permite funções nomeadas aninhadas nem módulos locais, mas oferece escopo de bloco granular em qualquer `{}` ou comando de controle (`if`, `for`, `switch`).
* **Decisão de projeto:** Modula-2 herdou o modelo de blocos de Algol/Pascal para estruturar algoritmos hierarquicamente e restringir visibilidade via módulos locais. Go seguiu a tradição de C aprimorada, permitindo que variáveis auxiliares (como índices de laço e variáveis de erro `if err := ...; err != nil`) vivam apenas onde são necessárias.
* **Vantagem / Desvantagem / Trade-off:** O escopo de bloco de Go melhora a **modificabilidade** e reduz o tempo de vida de variáveis temporárias, evitando vazamento de estado dentro de funções longas. Por outro lado, o operador `:=` combinado com escopo de bloco facilita o **sombreamento acidental** de variáveis externas (um erro clássico em Go que reduz a **confiabilidade** se o programador não estiver atento). Já Modula-2 evita esse tipo de sombreamento dentro do mesmo procedimento, mas obriga a declarar todas as variáveis no topo, aumentando o escopo de variáveis auxiliares.
