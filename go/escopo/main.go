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
