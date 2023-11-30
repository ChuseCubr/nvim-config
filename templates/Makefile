cc := gcc.exe
cflags := -Werror -Wall -Wpedantic -pedantic

src := src/main.c
target := build/out

$(target): $(src)
	$(cc) $(src) $(cflags) -o $(target)
