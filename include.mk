# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

SHELL = /bin/bash

PATH_TO_ROOT_DIRECTORY = $(dir $(lastword $(MAKEFILE_LIST)))

include $(PATH_TO_ROOT_DIRECTORY)/utils.mk
include $(PATH_TO_ROOT_DIRECTORY)/settings.mk
include $(PATH_TO_ROOT_DIRECTORY)/variables.mk
include $(PATH_TO_ROOT_DIRECTORY)/dependencies.mk
