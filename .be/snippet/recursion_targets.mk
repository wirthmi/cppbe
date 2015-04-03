# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

SUBMAKES = $(patsubst %/,%,$(dir $(wildcard */Makefile)))

.SECONDEXPANSION:

all clean: $(addprefix submake-,$(addsuffix -$$@,$(SUBMAKES)))

$(SUBMAKES): submake-$$@-all

submake-%: _SUBMAKE_NAME = $(call FUNCTION_GET_SUBSTRING,$*,-,1)
submake-%: _SUBMAKE_TARGET = $(call FUNCTION_GET_SUBSTRING,$*,-,2)
submake-%:
	$(MAKE) -C $(_SUBMAKE_NAME)/ -j $(JOBS) $(_SUBMAKE_TARGET)
