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
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

# === SRC DIRECTORY RELATED SECTION =========

# a lookup for header and source paths, notice that all of them will be
# relative to the SRC_DIRECTORY and without the "./" prefix

HEADERS = $(call FUNCTION_FIND_FILES, \
	$(PATH_TO_SRC_DIRECTORY),.*\.($(SRC_HEADER_EXTENSIONS)))

SOURCES = $(call FUNCTION_FIND_FILES, \
	$(PATH_TO_SRC_DIRECTORY),.*\.$(SRC_SOURCE_EXTENSION))

HEADERS_AND_SOURCES = $(HEADERS) $(SOURCES)


# === BUILD DIRECTORY RELATED SECTION =========

PATH_TO_BUILD_LIBRARY = $(PATH_TO_BUILD_DIRECTORY)/$(BUILD_LIBRARY)

# derivation of dependency and object paths, similarly they are also relative
# to the BUILD_DIRECTORY and again without the "./" prefix

DEPENDENCIES = \
	$(SOURCES:.$(SRC_SOURCE_EXTENSION)=.$(BUILD_DEPENDENCY_EXTENSION))
OBJECTS = \
	$(SOURCES:.$(SRC_SOURCE_EXTENSION)=.$(BUILD_OBJECT_EXTENSION))

OBJECTS_ONLY_MAIN = \
	$(addsuffix .$(BUILD_OBJECT_EXTENSION),$(BUILD_EXECUTABLES))
OBJECTS_EXCEPT_MAIN = \
	$(filter-out $(OBJECTS_ONLY_MAIN),$(OBJECTS))
