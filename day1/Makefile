include ../makevars.inc

all:
	gnatmake $(GNATFLAGS) day1

clean:
	gnatclean day1

adainclude:
	ln -s $$(gnatls -v|grep adainclude) adainclude
