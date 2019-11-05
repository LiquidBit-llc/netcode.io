UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	CC=gcc
	CC_FLAGS=
	LINKER_FLAGS=-shared -lsodium
	TARGET=libnetcode-io.so
else
	CC=clang
	CC_FLAGS=-I../libsodium/src/libsodium/include
	LINKER_FLAGS=-L../libsodium/src/libsodium/.libs -dynamiclib -lsodium
	TARGET=libnetcode-io.dylib
endif

$(TARGET): netcode.o
	$(CC) $^ $(LINKER_FLAGS) -o $@

netcode.o: netcode.c
	$(CC) $< $(CC_FLAGS) -ffast-math -O3 -msse2 -Wall -Wextra -fPIC -c -o $@

.PHONY: clean

clean:
	rm *.o $(TARGET)
