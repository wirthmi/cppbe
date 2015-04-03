# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

include ../include.mk

DOXYGEN_CONFIG = doxygen.conf

HTML_DIRECTORY = html/
INDEX_FILE = index.html

all: $(INDEX_FILE)

clean:
	rm -rf $(INDEX_FILE) $(HTML_DIRECTORY)
	rm -f doxygen_*

$(INDEX_FILE): $(HTML_DIRECTORY)
	ln -sf $(HTML_DIRECTORY)/$@ $@

$(HTML_DIRECTORY): \
$(DOXYGEN_CONFIG) \
$(addprefix $(PATH_TO_SRC_DIRECTORY)/,$(HEADERS_AND_SOURCES))

	@ # launch documentation generator
	$(DOXYGEN) $<
