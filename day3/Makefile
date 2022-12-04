include ../makevars.inc

all:
	gnatmake $(GNATFLAGS) day3

clean:
	gnatclean day3

adainclude:
	ln -s $$(gnatls -v|grep adainclude) adainclude
