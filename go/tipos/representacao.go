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
