# 7. Tipos Primitivos

## Visão Geral Comparativa

| Categoria | Modula-2 | Go |
| :--- | :--- | :--- |
| **Inteiros com sinal** | `INTEGER`, `SHORTINT`, `LONGINT` (tamanhos dependentes da implementação) | `int` (dependente da arquitetura: 32 ou 64 bits), `int8`, `int16`, `int32`, `int64` |
| **Inteiros sem sinal** | `CARDINAL`, `SHORTCARD`, `LONGCARD` (tamanhos dependentes da implementação) | `uint`, `uint8` (`byte`), `uint16`, `uint32`, `uint64`, `uintptr` |
| **Ponto flutuante** | `REAL`, `LONGREAL` | `float32`, `float64` (padrão IEEE 754 garantido pela especificação) |
| **Números complexos** | Não nativo no PIM (adicionado como `COMPLEX` / `LONGCOMPLEX` apenas no padrão ISO) | Nativo: `complex64`, `complex128` |
| **Booleano** | `BOOLEAN` (`TRUE`, `FALSE`) | `bool` (`true`, `false`) |
| **Caractere** | `CHAR` (tipicamente 1 byte / ASCII) | Não há tipo `char` separado; usa-se `byte` (alias de `uint8`) e `rune` (alias de `int32`, ponto de código Unicode) |
| **Conversão implícita** | Proibida (exige conversão explícita, ex.: `FLOAT`, `TRUNC`, `VAL`) | Proibida (exige conversão explícita, ex.: `float64(x)`, `int(y)`) |

---

## Exemplo Comparativo de Código

### Modula-2 (`modula2/tipos/primitivos.mod`)
```modula2
MODULE Primitivos;

FROM InOut IMPORT WriteInt, WriteCard, WriteString, WriteLn, Write;
FROM RealInOut IMPORT WriteReal;

VAR
  saldo: INTEGER;
  quantidade: CARDINAL;
  preco: REAL;
  ativo: BOOLEAN;
  letra: CHAR;
  total: REAL;

BEGIN
  saldo := -15;
  quantidade := 4;
  preco := 12.5;
  ativo := TRUE;
  letra := 'G';

  (* Conversao obrigatoriamente explicita entre CARDINAL e REAL *)
  total := FLOAT(quantidade) * preco;

  WriteString("Saldo (INTEGER): "); WriteInt(saldo, 0); WriteLn;
  WriteString("Quantidade (CARDINAL): "); WriteCard(quantidade, 0); WriteLn;
  WriteString("Total (REAL): "); WriteReal(total, 10); WriteLn;
  WriteString("Letra (CHAR): "); Write(letra); WriteLn;

  IF ativo THEN
    WriteString("Status: Ativo"); WriteLn;
  END;
END Primitivos.
```

### Go (`go/tipos/primitivos.go`)
```go
package main

import "fmt"

func main() {
	var saldo int = -15
	var quantidade uint = 4
	var preco float64 = 12.5
	var ativo bool = true
	var letra rune = 'G' // Alias para int32 (Unicode)

	// Conversao obrigatoriamente explicita entre uint e float64
	total := float64(quantidade) * preco

	fmt.Println("Saldo (int):", saldo)
	fmt.Println("Quantidade (uint):", quantidade)
	fmt.Printf("Total (float64): %.2f\n", total)
	fmt.Printf("Letra (rune): %c (codigo Unicode: %d)\n", letra, letra)

	if ativo {
		fmt.Println("Status: Ativo")
	}
}
```

---

## Análise Comparativa e Decisões de Projeto

### 1. Inteiros: `INTEGER`/`CARDINAL` vs. Tipos de Largura Fixa em Go
* **Mecanismo:** Modula-2 separa explicitamente inteiros com sinal (`INTEGER`) e sem sinal (`CARDINAL`), deixando o tamanho exato em bits a cargo do compilador/arquitetura. Go também oferece `int` e `uint` dependentes da arquitetura, mas fornece nativamente tipos com largura exata (`int8` a `int64`, `uint8` a `uint64`).
* **Decisão de projeto:** Wirth introduziu `CARDINAL` para expressar matematicamente valores não negativos (como índices e contadores) e evitar a ambiguidade de inteiros com sinal. Go herdou a separação, mas incorporou larguras fixas na especificação para lidar com protocolos de rede, serialização binária e portabilidade entre arquiteturas modernas (32/64 bits).
* **Vantagem / Desvantagem / Trade-off:** A abordagem de Modula-2 prioriza a eficiência na palavra nativa da máquina, mas reduz a **portabilidade** (um `INTEGER` podia ter 16 bits em uma máquina e 32 em outra). Go garante **portabilidade** e previsibilidade em protocolos binários com `int32`/`uint64`, mantendo `int` como padrão ergonômico para contadores comuns.

### 2. Caracteres: `CHAR` (ASCII) vs. `rune` e `byte` (Unicode)
* **Mecanismo:** Modula-2 define `CHAR` como um tipo primitivo distinto, historicamente mapeado para 1 byte (ASCII). Go não possui um tipo `char` próprio: usa `byte` (`uint8`) para dados brutos e `rune` (`int32`) para representar qualquer ponto de código Unicode (UTF-8).
* **Decisão de projeto:** Em 1978, o padrão dominante era ASCII de 7/8 bits, onde 1 caractere sempre equivalia a 1 byte. Em 2009, softwares globais precisavam suportar acentos, alfabetos não latinos e emojis nativamente.
* **Vantagem / Desvantagem / Trade-off:** O `CHAR` de Modula-2 é extremamente simples e econômico em memória (1 byte fixo), mas inadequado para internacionalização moderna. O modelo de Go (`rune`/`byte`) eleva a **portabilidade** e a correção no tratamento de texto internacional, ao custo de maior complexidade conceitual (um caractere pode ocupar de 1 a 4 bytes em UTF-8).

### 3. Ausência de Conversões Implícitas (Tipagem Forte)
* **Mecanismo:** Tanto Modula-2 quanto Go proíbem coerções implícitas entre tipos numéricos diferentes — não é possível multiplicar `CARDINAL` por `REAL` em Modula-2 nem `uint` por `float64` em Go sem conversão explícita.
* **Decisão de projeto:** Ambas rejeitam o modelo permissivo de C, onde promoções implícitas causam perda silenciosa de precisão ou erros de sinal (*signed/unsigned*).
* **Vantagem / Desvantagem / Trade-off:** Aumenta drasticamente a **confiabilidade** e a **legibilidade** (toda perda de precisão ou mudança de representação fica visível no código), ao custo de uma leve perda de **redigibilidade** por exigir conversões explícitas frequentes.
