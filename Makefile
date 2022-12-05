SUBDIR=day1 day2 day3 day4 day5

define make-subdir
	@for d in $(SUBDIR); do \
		make -C $$d $@; \
	done
endef

all:
	$(make-subdir)

clean:
	$(make-subdir)
