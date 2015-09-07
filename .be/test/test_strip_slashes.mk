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


ifneq "$(call strip_slashes,path////to/strip///)" "path/to/strip/"
$(warning failed: \
	strip_slashes > strips path with redundant slashes \
)
endif


ifneq "$(call strip_slashes,already/stripped/path)" "already/stripped/path"
$(warning failed: \
	strip_slashes > doesn't change path with no redundant slashes \
)
endif
