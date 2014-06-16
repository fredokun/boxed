
JADE=jade
STYLUS=stylus

EXAMPLE1_FILES= boxstyle1.css example1.html

all: example1

example1: $(EXAMPLE1_FILES)

%.css: %.styl
	$(STYLUS) < $< > $@ 

%.html: %.jade
	$(JADE) < $< > $@


clean:
	rm -vf *~


cleanall: clean
	rm -vf $(EXAMPLE1_FILES)
