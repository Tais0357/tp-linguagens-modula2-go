package main

import "fmt"

const Limite = 10 // Constante exportável (maiúscula) e sem tipo fixo inicial

func main() {
	var contador int = Limite + 5 // Declaração explícita
	dobro := contador * 2         // Inferência de tipo (amarração estática para int)

	fmt.Println(contador, dobro)
}
