include ../makevars.inc

all:
	gnatmake $(GNATFLAGS) day8

clean:
	gnatclean day8

adainclude:
	ln -s $$(gnatls -v|grep adainclude) adainclude
