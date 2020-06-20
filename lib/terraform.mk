REPO_ROOT ?= $(shell git rev-parse --show-toplevel)

AWS_SUDO ?= $(shell which awsudo)
TERRAFORM ?= $(AWS_SUDO) -u $(AWS_PROFILE) $(REPO_ROOT)/bin/terraform

TF_PLAN_FILE = tfplan

default: usage

.PHONY: usage
usage:
	@echo "Usage:"
	@echo "  make plan"
	@echo "  make apply"

.PHONY: clean
clean:
	@echo "[Makefile] Deleting previous plan files..."
	@find . -name $(TF_PLAN_FILE) -type f -exec rm -v {} \;

.PHONY: fmt
fmt:
	$(TERRAFORM) fmt

.PHONY: validate
format:
	$(TERRAFORM) validate

.PHONY: prepare
prepare: clean fmt
	$(TERRAFORM) init -upgrade

plan: prepare
	$(TERRAFORM) plan -out=$(TF_PLAN_FILE)
	@echo "Deployment plan $(TF_PLAN_FILE) is ready."

apply:
	$(TERRAFORM) apply $(TF_PLAN_FILE)
	@rm -f $(TF_PLAN_FILE)
