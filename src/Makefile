# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

include ../include.mk

all clean:

style: $(HEADERS_AND_SOURCES)

.PHONY: $(HEADERS_AND_SOURCES)

$(HEADERS_AND_SOURCES):
	@ $(call SRC_STYLE_COMMAND,$@)
