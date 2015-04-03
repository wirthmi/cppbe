# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

PATH_TO_BE_DIRECTORY = $(dir $(filter %init.mk,$(MAKEFILE_LIST)))

include $(PATH_TO_BE_DIRECTORY)/functions.mk
include $(PATH_TO_BE_DIRECTORY)/presets_1.mk
include $(PATH_TO_BE_DIRECTORY)/config.mk
include $(PATH_TO_BE_DIRECTORY)/presets_2.mk

include $(PATH_TO_SNIPPET_DIRECTORY)/global_targets.mk
