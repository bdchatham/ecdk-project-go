# Variables
GO=go
GOPATH=$(shell go env GOPATH)
GOBIN=$(GOPATH)/bin
GOLINT=$(GOBIN)/golangci-lint

.PHONY: all clean test lint fmt dev help

all: dev

clean:
	@echo "Cleaning up test and cache artifacts..."
	$(GO) clean -testcache

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

dev: fmt lint test

help:
	@echo "Available targets:"
	@echo "  all        - Run dev tasks (fmt, lint, test)"
	@echo "  clean      - Clean up build/test artifacts"
	@echo "  test       - Run Go tests"
	@echo "  lint       - Run golangci-lint"
	@echo "  fmt        - Format code with gofmt"
	@echo "  dev        - Run fmt, lint, and test"
