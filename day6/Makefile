include ../makevars.inc

all:
	gnatmake $(GNATFLAGS) day6

clean:
	gnatclean day6

adainclude:
	ln -s $$(gnatls -v|grep adainclude) adainclude
