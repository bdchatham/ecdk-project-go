# Variables
BINARY_NAME=ecdk-app
GO=go
GOPATH=$(shell go env GOPATH)
GOBIN=$(GOPATH)/bin
GOLINT=$(GOBIN)/golangci-lint

# Build flags
LDFLAGS=-ldflags "-s -w"

.PHONY: all build clean test lint fmt install uninstall

all: clean build

build:
	@echo "Building $(BINARY_NAME)..."
	$(GO) build $(LDFLAGS) -o bin/$(BINARY_NAME) ./src/main.go

clean:
	@echo "Cleaning..."
	rm -rf bin/
	rm -rf ecdk.out/

test:
	@echo "Running tests..."
	$(GO) test -v ./...

lint:
	@echo "Running linter..."
	@if [ ! -f $(GOLINT) ]; then \
		echo "Installing golangci-lint..."; \
		curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(GOBIN) v1.55.2; \
	fi
	$(GOLINT) run

fmt:
	@echo "Formatting code..."
	$(GO) fmt ./...

install: build
	@echo "Installing $(BINARY_NAME)..."
	cp bin/$(BINARY_NAME) $(GOBIN)/

uninstall:
	@echo "Uninstalling $(BINARY_NAME)..."
	rm -f $(GOBIN)/$(BINARY_NAME)

# Development helpers
dev: fmt lint test build

# Help
help:
	@echo "Available targets:"
	@echo "  all        - Clean and build"
	@echo "  build      - Build the binary"
	@echo "  clean      - Remove build artifacts"
	@echo "  test       - Run tests"
	@echo "  lint       - Run linter"
	@echo "  fmt        - Format code"
	@echo "  install    - Install binary to GOPATH"
	@echo "  uninstall  - Remove binary from GOPATH"
	@echo "  dev        - Run fmt, lint, test, and build"
