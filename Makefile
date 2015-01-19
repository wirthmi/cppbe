# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

include include.mk

MODULES = $(shell ls ./*/Makefile |cut -d / -f 2)

.SECONDEXPANSION:

all clean: $(addprefix module-,$(addsuffix -$$@,$(MODULES)))

$(MODULES): module-$$@-all

module-%: _MODULE_NAME = $(call FUNCTION_GET_SUBSTRING,$*,-,1)
module-%: _MODULE_TARGET = $(call FUNCTION_GET_SUBSTRING,$*,-,2)
module-%:
	$(MAKE) -C ./$(_MODULE_NAME)/ -j $(JOBS) $(_MODULE_TARGET)
