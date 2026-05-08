# Phone Backup Tool Makefile

.DEFAULT_GOAL := run
.PHONY: run check help

# Main target: executes the backup process
run:
	@printf "[\033[34m*\033[0m] Starting phone backup...\n"
	@chmod +x backup-phone.sh rcp
	@./backup-phone.sh

# Validation target: ensures rsync is installed
check:
	@which rsync > /dev/null || (echo "Error: rsync not found." && exit 1)
	@printf "[\033[32mOK\033[0m] Dependencies satisfied.\n"

# Help target: lists available commands
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  run     (default) Execute the backup script"
	@echo "  check   Verify system dependencies"
	@echo "  help    Show this help message"
