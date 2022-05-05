source = main.c string.c
include = ask.h
build : $(source) $(include)
	gcc $(source) $(include) -o a1.out
run :
	./a1.out