UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	CC=gcc
	TARGET=libnetcode-io.so
else
	CC=clang
	TARGET=libnetcode-io.dylib
endif

$(TARGET): netcode.o
	$(CC) -fPIC -shared -L../libs -lsodium -o $@ $^

netcode.o: netcode.c
	$(CC) $< -ffast-math -O3 -msse2 -Wall -Wextra -fPIC -DSODIUM_STATIC -c -g -o $@

.PHONY: clean

clean:
	rm *.o $(TARGET)
