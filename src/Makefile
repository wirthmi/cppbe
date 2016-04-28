# Smart GNU Make based build environment for C++.
# Copyright (C) 2015-2016  Michal Wirth <wirthmi@rankl.cz>

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


include ../.be/init.mk


all clean: _force


# applies astyle rules separately on each header or source file, single astyle
# process could be launched also in a recursive mode but then it wouldn't be
# possible to let the make apply style just on one selected file

style: $(SRC_HEADER_FILES) $(SRC_SOURCE_FILES)

$(SRC_HEADER_FILES) $(SRC_SOURCE_FILES): _force

	@ $(ASTYLE) $(SRC_ASTYLE_RULES) $@
