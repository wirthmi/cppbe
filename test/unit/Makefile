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
include $(PATH_TO_BE_TARGET_DIRECTORY)/clean.mk


_CATCH = catch

_SOURCE_FILES = \
	$(_CATCH).$(SRC_SOURCE_EXTENSION) \
	$(call find_by_regexp,./,test_[a-z0-9_]+\.$(SRC_SOURCE_EXTENSION))

_OBJECT_FILES = $(patsubst \
	%.$(SRC_SOURCE_EXTENSION),%.$(BUILD_OBJECT_EXTENSION),$(_SOURCE_FILES))


all: run

clean: _clean

run: $(_CATCH) _force

	./$(_CATCH) --durations yes


$(eval $(call place_executable_files_building_target, \
	$(_CATCH), \
	$(PATH_TO_BUILD_LIBRARY_FILE), \
	$(_OBJECT_FILES) \
))

$(eval $(call place_object_files_building_target, \
	$(_OBJECT_FILES), \
	./ \
))

$(eval $(call place_make_slaves_target, \
	$(PATH_TO_BUILD_LIBRARY_FILE) \
))
