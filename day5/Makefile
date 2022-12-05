include ../makevars.inc

all:
	gnatmake $(GNATFLAGS) day5

clean:
	gnatclean day5

adainclude:
	ln -s $$(gnatls -v|grep adainclude) adainclude
