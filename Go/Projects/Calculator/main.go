package main

import (
	"fmt"
	"calculator_go/Calculatorv1"
)

func main() {
	var option string
	var num1, num2 int64

	// --- Program Title ---
	fmt.Println("===================")
	fmt.Println("  Go Calculator  ")
	fmt.Println("===================")
	fmt.Println() // Extra newline for spacing

	// --- Menu Options ---
	fmt.Println("Select an option:")
	fmt.Println("1 - Add")
	fmt.Println("2 - Subtract")
	fmt.Print("Your option: ")

	// Read user's option
	_, err := fmt.Scanln(&option)
	if err != nil {
		fmt.Println("\nError: Could not read option. Details:", err)
		return
	}

	// Process valid options that require number input
	if option == "1" || option == "2" {
		fmt.Println() // Extra newline for spacing
		fmt.Print("Enter the first number: ")
		_, errX := fmt.Scanln(&num1)
		if errX != nil {
			fmt.Println("\nError: Could not read the first number. Details:", errX)
			return
		}

		fmt.Print("Enter the second number: ")
		_, errY := fmt.Scanln(&num2)
		if errY != nil {
			fmt.Println("\nError: Could not read the second number. Details:", errY)
			return
		}

		fmt.Println("-------------------") // Separator before displaying the result

		// Perform calculation based on option
		if option == "1" {
			result := calculator.Sum(num1, num2)
			fmt.Printf("Result: %d + %d = %d\n", num1, num2, result)
		} else if option == "2" {
			result := calculator.Sub(num1, num2)
			fmt.Printf("Result: %d - %d = %d\n", num1, num2, result)
		}
		fmt.Println("-------------------") // Separator after displaying the result
	} else {
		fmt.Println("\nInvalid option selected. Please run the program again and choose 1 or 2.")
	}
	fmt.Println() // Final newline for clean exit
}