# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

PATH_TO_BE_DIRECTORY = $(dir $(filter %init.mk,$(MAKEFILE_LIST)))

# load all internals of build enviroment in strictly defined order
include $(wildcard $(PATH_TO_BE_DIRECTORY)/??-*.mk)

# load some basic shared targets, nothing fancy
include $(PATH_TO_TARGET_DIRECTORY)/global.mk
