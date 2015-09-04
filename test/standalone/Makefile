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

include ../../.be/init.mk

include $(PATH_TO_TARGET_DIRECTORY)/clean.mk

TEST_SOURCES = $(call FUNCTION_FIND_FILES, \
	./,test_[a-z_]+(-[a-z_]+)?\.$(SRC_SOURCE_EXTENSION))

TEST_OBJECTS = \
	$(TEST_SOURCES:.$(SRC_SOURCE_EXTENSION)=.$(BUILD_OBJECT_EXTENSION))
TEST_OBJECTS_ONLY_MAIN = \
	$(call FUNCTION_FILTER_BY_REGEXP,(^|/)[a-z_]+\.,$(TEST_OBJECTS))
TEST_OBJECTS_EXCEPT_MAIN = \
	$(call FUNCTION_FILTER_BY_REGEXP,[-][a-z_]+\.,$(TEST_OBJECTS))

TEST_EXECUTABLES = \
	$(TEST_OBJECTS_ONLY_MAIN:.$(BUILD_OBJECT_EXTENSION)=)

all: $(TEST_EXECUTABLES)

# this needs some explanation, the following uses echo \x25 trick which prints
# a % character for the filter function but after expansion of the stem by a
# static pattern rule inside FUNCTION_GET_EXECUTABLES_BUILDING_TARGET function

$(eval $(call FUNCTION_GET_EXECUTABLES_BUILDING_TARGET, \
	$(TEST_EXECUTABLES), \
	$(PATH_TO_BUILD_LIBRARY) %.$(BUILD_OBJECT_EXTENSION) \
	\
	$$$$(filter \
		%-$$$$(shell echo -ne '\x25').$(BUILD_OBJECT_EXTENSION), \
		$(TEST_OBJECTS_EXCEPT_MAIN) \
	) \
))

$(eval $(call FUNCTION_GET_OBJECTS_BUILDING_TARGET, \
	$(TEST_OBJECTS), \
	%.$(SRC_SOURCE_EXTENSION) \
))

$(eval $(call FUNCTION_GET_FORCING_SUBMAKES_TARGET, \
	$(PATH_TO_BUILD_LIBRARY) \
))
