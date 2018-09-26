## 
#	Makefile for matmult.cpp
##

FILENAME = matmult

CC = c++
CXX_FLAGS = -g -O0

debug/matmult : src/$(FILENAME).cu
	$(CC) $(CXX_FLAGS) -o debug/$(FILENAME) src/$(FILENAME).cu

run: debug/$(FILENAME)
	./debug/$(FILENAME)

clean:
	rm debug/$(FILENAME)