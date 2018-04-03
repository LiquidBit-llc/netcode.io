UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	CC=gcc
	LINKER_FLAGS=-shared -Wl,--whole-archive -l:libsodium.a -Wl,--no-whole-archive 
	TARGET=libnetcode-io.so
else
	CC=clang
	LINKER_FLAGS=-dynamiclib -lsodium
	TARGET=libnetcode-io.dylib
endif

$(TARGET): netcode.o
	$(CC) $(LINKER_FLAGS) -o $@ $^

netcode.o: netcode.c
	$(CC) $< -ffast-math -O3 -msse2 -Wall -Wextra -fPIC -DSODIUM_STATIC -c -g -o $@

.PHONY: clean

clean:
	rm *.o $(TARGET)
