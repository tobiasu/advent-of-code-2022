SUBDIR=day1

define make-subdir
	for d in $(SUBDIR); do \
		make -C $$d $@; \
	done
endef

all:
	$(make-subdir)

clean:
	$(make-subdir)
