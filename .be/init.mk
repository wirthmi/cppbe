# Smart GNU Make based build environment for C++.
# Copyright (C) 2015  Michal Wirth <wirthmi@rankl.cz>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax


SHELL = /bin/bash

MAKEFLAGS += -j $(shell nproc)

.DEFAULT_GOAL = all


# assign main build enviroment directory and file paths

BE_DIRECTORY = .be/
PATH_TO_BE_DIRECTORY = $(dir $(filter %init.mk,$(MAKEFILE_LIST)))

BE_INCLUDE_DIRECTORY = include/
PATH_TO_BE_INCLUDE_DIRECTORY = $(PATH_TO_BE_DIRECTORY)/$(BE_INCLUDE_DIRECTORY)

BE_TARGET_DIRECTORY = target/
PATH_TO_BE_TARGET_DIRECTORY = $(PATH_TO_BE_DIRECTORY)/$(BE_TARGET_DIRECTORY)

BE_CONFIG_FILE = config.mk
PATH_TO_BE_CONFIG_FILE = $(PATH_TO_BE_DIRECTORY)/$(BE_CONFIG_FILE)

PATH_TO_ROOT_DIRECTORY = \
	$(dir $(patsubst %$(BE_DIRECTORY),%.,$(PATH_TO_BE_DIRECTORY)))


# load all internals in a strictly defined order, also load some basic shared
# targets - nothing fancy there

include $(sort $(wildcard $(PATH_TO_BE_INCLUDE_DIRECTORY)/??-*.mk))

include $(PATH_TO_BE_TARGET_DIRECTORY)/global.mk
