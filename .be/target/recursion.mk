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


# a pattern rule target formed as _recurse-<filter>-<target> which selects sub-
# directories containing Makefiles - let's call them slaves, filters them by
# the <filter> field and then launches appropriate submakes making the <target>
# on them

RECURSE_SLAVES = $(patsubst %/,%,$(dir $(wildcard */Makefile)))

_recurse-%: _SLAVES = $(filter $(call cut,-,1,$*),$(RECURSE_SLAVES))
_recurse-%: _TARGET = $(call cut,-,2,$*)

_recurse-%: \
$$(addprefix _recurse_submake-,$$(addsuffix -$$(_TARGET),$$(_SLAVES)))

	@ # pattern rule recipes can't be empty, single comment is sufficient

_recurse_submake-%: _SLAVE = $(call cut,-,1,$*)
_recurse_submake-%: _TARGET = $(call cut,-,2,$*)

_recurse_submake-%: _force

	@ $(MAKE) -C $(_SLAVE)/ $(_TARGET)
