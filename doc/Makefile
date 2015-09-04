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

include ../.be/init.mk

include $(PATH_TO_TARGET_DIRECTORY)/clean.mk

DOXYGEN_CONFIG = doxygen.conf

HTML_DIRECTORY = html/
INDEX_FILE = index.html

all: $(INDEX_FILE)

$(INDEX_FILE): $(HTML_DIRECTORY)
	ln -sf $</$@ $(call FUNCTION_ADD_CLEAN_RECORD,$@)

$(HTML_DIRECTORY): $(DOXYGEN_CONFIG) $(PATHS_TO_SRC_HEADERS_AND_SOURCES)

	@ # launch documentation generator, it produces a lot of stuff
	$(DOXYGEN) $<

	@ # that will be here ...
	@ $(call FUNCTION_GET_FILES_FINDER,./,doxygen_.*) \
		| $(call FUNCTION_GET_CLEAN_RECORD_ADDER) \
		> /dev/null

	@ # and here registered as clean records and therefore later cleaned
	@ $(call FUNCTION_GET_FILES_FINDER,$(HTML_DIRECTORY),.*) \
		| sed 's#^#$(HTML_DIRECTORY)/#' \
		| $(call FUNCTION_GET_CLEAN_RECORD_ADDER) \
		> /dev/null
