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

SLAVES = $(patsubst %/,%,$(dir $(wildcard */Makefile)))

$(SLAVES): _make-$$@-all

_recurse-%: _SLAVES = $(filter $(call FUNCTION_GET_SUBSTRING,$*,-,1),$(SLAVES))
_recurse-%: _TARGET = $(call FUNCTION_GET_SUBSTRING,$*,-,2)

_recurse-%: $$(addprefix _make-,$$(addsuffix -$$(_TARGET),$$(_SLAVES)))
	@ # pattern rule recipes can't be empty, single comment is sufficient

_make-%: _SLAVE = $(call FUNCTION_GET_SUBSTRING,$*,-,1)
_make-%: _TARGET = $(call FUNCTION_GET_SUBSTRING,$*,-,2)

_make-%: FORCE
	@ $(MAKE) -C $(_SLAVE)/ $(_TARGET);
