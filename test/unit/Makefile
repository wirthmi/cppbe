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

include ../../.be/init.mk

include $(PATH_TO_TARGET_DIRECTORY)/clean.mk

CATCH = catch

CATCH_SOURCE = \
	$(CATCH).cpp
CATCH_OBJECT = \
	$(CATCH_SOURCE:.cpp=.$(BUILD_OBJECT_EXTENSION))

TEST_SOURCES = \
	$(call FUNCTION_FIND_FILES,./,test_[a-z_]+\.$(SRC_SOURCE_EXTENSION))
TEST_OBJECTS = \
	$(TEST_SOURCES:.$(SRC_SOURCE_EXTENSION)=.$(BUILD_OBJECT_EXTENSION))

all: $(CATCH)

run: $(CATCH) FORCE
	./$< --durations yes

$(eval $(call FUNCTION_GET_EXECUTABLES_BUILDING_TARGET, \
	$(CATCH), \
	$(CATCH_OBJECT) $(TEST_OBJECTS) $(PATH_TO_BUILD_LIBRARY) \
))

$(eval $(call FUNCTION_GET_OBJECTS_BUILDING_TARGET, \
	$(CATCH_OBJECT) $(TEST_OBJECTS), \
	%.$(SRC_SOURCE_EXTENSION) \
))

$(eval $(call FUNCTION_GET_FORCING_SUBMAKES_TARGET, \
	$(PATH_TO_BUILD_LIBRARY) \
))
