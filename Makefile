# Makefile

PIL_MODULE_DIR ?= .modules
PIL_SYMLINK_DIR ?= .lib

## Edit below
BUILD_REPO = https://github.com/rg3/bcrypt.git
BUILD_DIR = $(PIL_MODULE_DIR)/bcrypt/HEAD
BUILD_REF = b1e3dea0a1
TARGET = libbcrypt.so
FILES = bcrypt.c crypt_blowfish/crypt_blowfish.c crypt_blowfish/crypt_gensalt.c crypt_blowfish/wrapper.c
INCLUDES = -I. -Icrypt_blowfish/
CFLAGS = -O2 -g -fPIC -shared
## Edit above

# Unit testing
TEST_REPO = https://github.com/aw/picolisp-unit.git
TEST_DIR = $(PIL_MODULE_DIR)/picolisp-unit/HEAD

# Generic
CC = gcc

COMPILE = $(CC) $(CFLAGS)

SHARED = -Wl,-soname,$(TARGET)

.PHONY: all clean

all: $(BUILD_DIR) $(BUILD_DIR)/$(TARGET) symlink

$(BUILD_DIR):
		mkdir -p $(BUILD_DIR) && \
		git clone $(BUILD_REPO) $(BUILD_DIR)

$(TEST_DIR):
		mkdir -p $(TEST_DIR) && \
		git clone $(TEST_REPO) $(TEST_DIR)

$(BUILD_DIR)/$(TARGET):
		cd $(BUILD_DIR) && \
		git checkout $(BUILD_REF) && \
		$(COMPILE) $(SHARED) -o $(TARGET) $(FILES) && \
		strip --strip-unneeded $(TARGET)

symlink:
		mkdir -p $(PIL_SYMLINK_DIR) && \
		cd $(PIL_SYMLINK_DIR) && \
		ln -sf ../$(BUILD_DIR)/$(TARGET) $(TARGET)

check: all $(TEST_DIR) run-tests

run-tests:
		./test.l

clean:
		cd $(BUILD_DIR) && \
		rm -f $(TARGET) && \
		cd - && \
		cd $(PIL_SYMLINK_DIR) && \
		rm -f $(TARGET)
