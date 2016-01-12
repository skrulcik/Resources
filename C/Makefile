#
# Makefile for the malloc lab driver
#
CC = gcc
CFLAGS = -Wall -Wextra -Werror -O3 -g -DDRIVER -std=gnu99 -Wno-unused-function -Wno-unused-parameter
TESTABLE = list.o
all: test

csapp.o: csapp.c csapp.h
	$(CC) -Wall -Wextra -O3 -g -DDRIVER -std=gnu99 -Wno-unused-function -Wno-unused-parameter -c csapp.c

list.o: list.c list.h csapp.h
	$(CC) $(CFLAGS) -c list.c

test.o: test.c $(TESTABLE)
	$(CC) $(CFLAGS) -c test.c

test: test.o $(TESTABLE) csapp.o

clean:
	rm -f *~ *.o test



