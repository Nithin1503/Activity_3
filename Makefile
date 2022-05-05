source = main.c name.c
include = char.h
build : $(source) $(include)
	gcc $(source) $(include) -o a1.out
run :
	./a1.out
