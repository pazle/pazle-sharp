# !/usr/bin/bash

dmd src/pazle.d \
	src/exec.d \
	src/parser.d \
	src/lexer.d \
	src/inter.d \
	src/ast/node.d \
	\
	\
	src/ast/bytecode.d\
	src/ast/bytecode2.d\
	\
	\
	src/objects/object.d\
	src/objects/number.d\
	src/objects/string.d\
	src/objects/function.d\

./pazle
