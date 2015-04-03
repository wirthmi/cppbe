# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

PATH_TO_ROOT_DIRECTORY = $(dir $(lastword $(MAKEFILE_LIST)))

include $(PATH_TO_ROOT_DIRECTORY)/functions.mk
include $(PATH_TO_ROOT_DIRECTORY)/environment.mk
include $(PATH_TO_ROOT_DIRECTORY)/configuration.mk
include $(PATH_TO_ROOT_DIRECTORY)/derivation.mk

.PHONY: FORCE

FORCE:
