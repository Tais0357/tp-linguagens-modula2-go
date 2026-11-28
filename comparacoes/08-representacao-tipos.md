# 8. Representação dos Tipos

## Visão Geral Comparativa

| Aspecto | Modula-2 | Go |
| :--- | :--- | :--- |
| **Definição de tamanho e faixa** | Em grande parte **dependente da implementação** (especificação não fixa a quantidade de bits de `INTEGER`, `CARDINAL` ou `REAL`) | **Definida pela especificação** para tipos de largura fixa (`int8`..`int64`, `uint8`..`uint64`, `float32`, `float64`); apenas `int`/`uint` variam (32 ou 64 bits) |
| **Inteiros escolhidos para análise** | `INTEGER` e `CARDINAL` (tipicamente complemento de dois / binário puro na palavra nativa da máquina) | `int32` (complemento de dois, exatamente 32 bits) e `int` (32 ou 64 bits conforme a arquitetura) |
| **Ponto flutuante escolhido** | `REAL` (representação dependente do hardware/compilador; hoje geralmente IEEE 754) | `float64` (obrigatoriamente padrão **IEEE 754** de 64 bits pela especificação) |
| **Inspeção de limites e tamanho** | Funções padrão `MIN(T)`, `MAX(T)` e `TSIZE(T)` (via módulo `SYSTEM`) | Constantes no pacote `math` (`math.MinInt32`, `math.MaxInt32`, `math.MaxFloat64`) e `unsafe.Sizeof(x)` |

---

## Exemplo Comparativo de Código

Os exemplos abaixo consultam o tamanho em bytes e o conjunto de valores (mínimo e máximo) dos tipos inteiros nas duas linguagens.

### Modula-2 (`modula2/tipos/representacao.mod`)
```modula2
MODULE Representacao;

FROM InOut IMPORT WriteInt, WriteCard, WriteString, WriteLn;
FROM SYSTEM IMPORT TSIZE;

BEGIN
  WriteString("Tamanho de INTEGER (bytes): ");
  WriteCard(TSIZE(INTEGER), 0);
  WriteLn;

  WriteString("MIN(INTEGER): ");
  WriteInt(MIN(INTEGER), 0);
  WriteLn;

  WriteString("MAX(INTEGER): ");
  WriteInt(MAX(INTEGER), 0);
  WriteLn;

  WriteString("MAX(CARDINAL): ");
  WriteCard(MAX(CARDINAL), 0);
  WriteLn;
END Representacao.
```

### Go (`go/tipos/representacao.go`)
```go
package main

import (
	"fmt"
	"math"
	"unsafe"
)

func main() {
	var a int32
	var b float64

	fmt.Println("Tamanho de int32 (bytes):", unsafe.Sizeof(a))
	fmt.Println("Min int32:", math.MinInt32)
	fmt.Println("Max int32:", math.MaxInt32)

	fmt.Println("Tamanho de float64 (bytes):", unsafe.Sizeof(b))
	fmt.Println("Max float64:", math.MaxFloat64)
}
```

---

## Análise Comparativa e Decisões de Projeto

### 1. Representação Dependente da Máquina vs. Especificada pela Linguagem
* **Mecanismo:** Em **Modula-2**, a especificação define o conjunto de valores de `INTEGER` apenas como um subconjunto dos inteiros matemáticos no intervalo `[MIN(INTEGER), MAX(INTEGER)]` e o de `CARDINAL` como `[0, MAX(CARDINAL)]`. Na estação Lilith original (16 bits), `INTEGER` ia de `-32768` a `32767`; em compiladores modernos como o `gm2` (arquiteturas 32/64 bits), `INTEGER` costuma ocupar 32 bits (`-2147483648` a `2147483647`). Em **Go**, a especificação fixa rigorosamente o conjunto de valores de `int32` (`-2147483648` a `2147483647`, complemento de dois) e de `float64` (IEEE 754 de precisão dupla), garantindo o mesmo comportamento em qualquer máquina.
* **Decisão de projeto:** Nos anos 1970/80, havia grande diversidade de tamanhos de palavra de CPU (16, 18, 24, 32, 36 bits) e formatos de ponto flutuante proprietários; Wirth deixou a representação aberta para que cada compilador usasse o formato nativo mais rápido do hardware. Em 2009, a indústria já havia convergido para complemento de dois e IEEE 754, permitindo a Go fixar essas representações na própria especificação.
* **Vantagem / Desvantagem / Trade-off:** A abordagem de Modula-2 favorece a **eficiência** em arquiteturas heterogêneas da época, mas prejudica a **portabilidade** e a **confiabilidade** (um cálculo que funciona em 32 bits pode sofrer *overflow* em 16 bits). Go garante altíssima **portabilidade** e previsibilidade matemática entre plataformas, ao custo de depender de arquiteturas modernas que sigam esses padrões.

### 2. Acesso a Metadados de Representação
* **Mecanismo:** Modula-2 oferece `MIN(T)` e `MAX(T)` diretamente na linguagem, mas isola `TSIZE(T)` no módulo de baixo nível `SYSTEM`, sinalizando explicitamente que o código depende de detalhes da máquina. Go também isola `unsafe.Sizeof` no pacote `unsafe` pelo mesmo motivo, mantendo limites numéricos em constantes do pacote `math`.
* **Decisão de projeto:** Ambas adotam o princípio de tornar explícita qualquer dependência de representação em memória, evitando que código de alto nível dependa silenciosamente do tamanho em bytes de um tipo.
* **Vantagem / Desvantagem / Trade-off:** Melhora a **legibilidade** e facilita auditorias de **portabilidade** (basta procurar por `IMPORT SYSTEM` ou `import "unsafe"` para encontrar trechos dependentes de hardware).
