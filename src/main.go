package main

import (
	"context"
	"log"

	"github.com/ecdk/ecdk/internal/constructs"
)

func main() {
	// Create a new stack
	stack := constructs.NewStack("ecdk-project-go", nil)

	// TODO: Add your constructs here

	// Synthesize the stack
	if err := stack.Synthesize(context.Background()); err != nil {
		log.Fatal(err)
	}
}
