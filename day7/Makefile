include ../makevars.inc

all:
	gnatmake $(GNATFLAGS) day7

clean:
	gnatclean day7

adainclude:
	ln -s $$(gnatls -v|grep adainclude) adainclude
