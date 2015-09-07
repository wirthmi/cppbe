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


ifneq "$(call filter_by_regexp,^[abc]xy.*z,ax bxyz  cxyffza xz)" "bxyz cxyffza"
$(warning failed: \
	filter_by_regexp > returns two filtered words as expected \
)
endif


ifneq "$(call filter_by_regexp,^[^ab]+$$,abraca dabra simsala bim)" ""
$(warning failed: \
	filter_by_regexp > returns no filtered words as expected \
)
endif
