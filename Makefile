UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	CC=gcc
	CC_FLAGS=
	LINKER_FLAGS=-shared -Wl,--whole-archive -l:libsodium.a -Wl,--no-whole-archive 
	TARGET=libnetcode-io.so
else
	CC=clang
	CC_FLAGS=-I../libsodium/src/libsodium/include
	LINKER_FLAGS=-dynamiclib -L../libsodium/src/libsodium/.libs -lsodium
	TARGET=libnetcode-io.dylib
endif

$(TARGET): netcode.o
	$(CC) $(LINKER_FLAGS) -o $@ $^

netcode.o: netcode.c
	$(CC) $< $(CC_FLAGS) -ffast-math -O3 -msse2 -Wall -Wextra -fPIC -DSODIUM_STATIC -c -g -o $@

.PHONY: clean

clean:
	rm *.o $(TARGET)
