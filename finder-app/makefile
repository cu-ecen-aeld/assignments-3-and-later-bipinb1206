CC := gcc
CROSS_COMPILE ?=

SRC_DIR := src
BUILD_DIR := build

TARGET := writer
SRC := $(wildcard $(SRC_DIR)/*.c)
OBJ := $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRC))

CFLAGS := -Wall -Werror
LDFLAGS :=

# Default target
.PHONY: all
all: $(BUILD_DIR) $(TARGET)

$(TARGET): $(BUILD_DIR) $(OBJ)
	$(CROSS_COMPILE)$(CC) $(LDFLAGS) -o $@ $(OBJ)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CROSS_COMPILE)$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Clean target
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) $(TARGET)

# Cross-compilation support
ifeq ($(CROSS_COMPILE),)
$(error CROSS_COMPILE is not specified. Please provide a cross-compiler prefix or use the native compiler.)
endif

