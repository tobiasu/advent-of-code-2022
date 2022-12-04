include ../makevars.inc

all:
	gnatmake $(GNATFLAGS) day4

clean:
	gnatclean day4

adainclude:
	ln -s $$(gnatls -v|grep adainclude) adainclude
