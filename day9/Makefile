include ../makevars.inc

all:
	gnatmake $(GNATFLAGS) day9

clean:
	gnatclean day9

adainclude:
	ln -s $$(gnatls -v|grep adainclude) adainclude
