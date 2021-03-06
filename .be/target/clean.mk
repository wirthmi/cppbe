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


# attempts to delete all files tracked by the cleanup file and always deletes
# empty directories which Git won't track anyway, see register_cleanup function
# for more information about the cleanup concept

_clean: _force

	if [ -r $(BUILD_CLEANUP_FILE) ]; then \
		xargs -a $(BUILD_CLEANUP_FILE) -d '\n' -I {} rm -f {}; \
		rm $(BUILD_CLEANUP_FILE); \
	fi

	find ./ -depth -type d -empty -exec rmdir {} \;
