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


$(info $(and \
	$(call register_cleanup,foo/a foo/b c) \
	$(call register_cleanup,d c foo/b f) \
	$(call register_cleanup,foo/a bar/e d) \
,))

ifneq \
"$(shell sort $(BUILD_CLEANUP_FILE) | paste -s -d ' ')" \
"bar/e c d f foo/a foo/b"
$(warning failed: \
	register_cleanup > registers cleanups uniquely as expected \
)
endif

$(info $(and \
	$(shell rm -f $(BUILD_CLEANUP_FILE)) \
,))
