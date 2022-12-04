include ../makevars.inc

all:
	gnatmake $(GNATFLAGS) day2

clean:
	gnatclean day2

adainclude:
	ln -s $$(gnatls -v|grep adainclude) adainclude
