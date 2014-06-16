
JADE=jade
STYLUS=stylus
COFFEE=coffee

EXAMPLE1_FILES= boxstyle1.css example1.html example1.js

all: example1

example1: $(EXAMPLE1_FILES)

%.js: %.coffee
	$(COFFEE) --compile $<

%.css: %.styl
	$(STYLUS) < $< > $@ 

%.html: %.jade
	$(JADE) < $< > $@


clean:
	rm -vf *~


cleanall: clean
	rm -vf $(EXAMPLE1_FILES)
