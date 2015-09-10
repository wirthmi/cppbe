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


_SOURCE_FILE = $(PATH_TO_SRC_DIRECTORY)/$(firstword \
	$(BUILD_EXECUTABLE_FILES)).$(SRC_SOURCE_EXTENSION)

ifneq \
"$(call get_extended_cxxflags,$(_SOURCE_FILE))" \
"$(CXXFLAGS) -DWAY_TO_SET_FILE_SPECIFIC_CXXFLAGS"
$(warning failed: \
	get_extended_cxxflags > constructs CXXFLAGS correctly on bare build \
	environment, anywhere else would fail \
)
endif
