## 
#	Makefile for matmult.cpp
##

matmult : src/matmult.cpp
	c++ -g -O0 -o matmult src/matmult.cpp

run: matmult
	./matmult

clean:
	rm matmult