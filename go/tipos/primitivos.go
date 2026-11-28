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
