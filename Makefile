SUBDIR=day1 day2 day3

define make-subdir
	for d in $(SUBDIR); do \
		make -C $$d $@; \
	done
endef

all:
	$(make-subdir)

clean:
	$(make-subdir)
