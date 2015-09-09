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


EDITOR := $(word 1,$(EDITOR) $(shell echo -n $${VISUAL} $${EDITOR}) $(VIM))


# lookup for paths to header and source files relative to src/ directory

SRC_HEADERS = $(call find_by_regexp, \
	$(PATH_TO_SRC_DIRECTORY),.*\.($(SRC_HEADER_EXTENSIONS)))

SRC_SOURCES = $(call find_by_regexp, \
	$(PATH_TO_SRC_DIRECTORY),.*\.$(SRC_SOURCE_EXTENSION))


# create paths to header and source files inclusive of path to src/ directory

PATHS_TO_SRC_HEADERS = $(addprefix $(PATH_TO_SRC_DIRECTORY)/,$(SRC_HEADERS))

PATHS_TO_SRC_SOURCES = $(addprefix $(PATH_TO_SRC_DIRECTORY)/,$(SRC_SOURCES))


# derive paths to object files relative to build/ directory

BUILD_OBJECTS = $(patsubst \
	%.$(SRC_SOURCE_EXTENSION),%.$(BUILD_OBJECT_EXTENSION),$(SRC_SOURCES))

BUILD_OBJECTS_ONLY_MAIN = $(addsuffix \
	.$(BUILD_OBJECT_EXTENSION),$(BUILD_EXECUTABLES))

BUILD_OBJECTS_EXCEPT_MAIN = $(filter-out \
	$(BUILD_OBJECTS_ONLY_MAIN),$(BUILD_OBJECTS))


# create paths executables and library inclusive of path to build/ directory

PATHS_TO_BUILD_EXECUTABLES = $(addprefix \
	$(PATH_TO_BUILD_DIRECTORY)/,$(BUILD_EXECUTABLES))

PATH_TO_1ST_EXECUTABLE = $(word 1,$(PATHS_TO_BUILD_EXECUTABLES))
PATH_TO_2ND_EXECUTABLE = $(word 2,$(PATHS_TO_BUILD_EXECUTABLES))
PATH_TO_3RD_EXECUTABLE = $(word 3,$(PATHS_TO_BUILD_EXECUTABLES))

PATH_TO_BUILD_LIBRARY_FILE = $(PATH_TO_BUILD_DIRECTORY)/$(BUILD_LIBRARY_FILE)
