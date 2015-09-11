# Smart GNU Make based build environment for C++.
# Copyright (C) 2015  Michal Wirth <wirthmi@rankl.cz>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax


EDITOR := $(word 1,$(EDITOR) $(shell echo -n $${VISUAL} $${EDITOR}) $(VIM))


# lookup for paths to header and source files relative to src/ directory

SRC_HEADER_FILES = $(call find_by_regexp, \
	$(PATH_TO_SRC_DIRECTORY),.*\.($(SRC_HEADER_EXTENSIONS)))

SRC_SOURCE_FILES = $(call find_by_regexp, \
	$(PATH_TO_SRC_DIRECTORY),.*\.$(SRC_SOURCE_EXTENSION))


# create paths to header and source files incl. path to src/ directory

PATHS_TO_SRC_HEADER_FILES = $(addprefix \
	$(PATH_TO_SRC_DIRECTORY)/,$(SRC_HEADER_FILES))

PATHS_TO_SRC_SOURCE_FILES = $(addprefix \
	$(PATH_TO_SRC_DIRECTORY)/,$(SRC_SOURCE_FILES))


# derive paths to object files relative to build/ directory

BUILD_OBJECT_FILES = $(patsubst \
	%.$(SRC_SOURCE_EXTENSION), \
	%.$(BUILD_OBJECT_EXTENSION), \
	$(SRC_SOURCE_FILES) \
)

BUILD_OBJECT_FILES_ONLY_MAIN = $(addsuffix \
	.$(BUILD_OBJECT_EXTENSION),$(BUILD_EXECUTABLE_FILES))

BUILD_OBJECT_FILES_EXCEPT_MAIN = $(filter-out \
	$(BUILD_OBJECT_FILES_ONLY_MAIN),$(BUILD_OBJECT_FILES))


# create paths to executable and library files incl. path to build/ directory

PATHS_TO_BUILD_EXECUTABLE_FILES = $(addprefix \
	$(PATH_TO_BUILD_DIRECTORY)/,$(BUILD_EXECUTABLE_FILES))

PATH_TO_1ST_EXECUTABLE_FILE = $(firstword $(PATHS_TO_BUILD_EXECUTABLE_FILES))
PATH_TO_2ND_EXECUTABLE_FILE = $(firstword $(PATHS_TO_BUILD_EXECUTABLE_FILES))
PATH_TO_3RD_EXECUTABLE_FILE = $(firstword $(PATHS_TO_BUILD_EXECUTABLE_FILES))

PATH_TO_BUILD_LIBRARY_FILE = $(PATH_TO_BUILD_DIRECTORY)/$(BUILD_LIBRARY_FILE)
