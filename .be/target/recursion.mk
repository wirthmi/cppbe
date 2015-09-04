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

SUBMAKES = $(patsubst %/,%,$(dir $(wildcard */Makefile)))

all clean: $(addprefix submake-,$(addsuffix -$$@,$(SUBMAKES)))

$(SUBMAKES): submake-$$@-all

submake-%: _SUBMAKE_NAME = $(call FUNCTION_GET_SUBSTRING,$*,-,1)
submake-%: _SUBMAKE_TARGET = $(call FUNCTION_GET_SUBSTRING,$*,-,2)
submake-%: FORCE

	@ # traverse with make into subdirectories
	$(MAKE) -C $(_SUBMAKE_NAME)/ -j $(JOBS) $(_SUBMAKE_TARGET)
