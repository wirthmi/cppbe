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


include .be/init.mk
include $(PATH_TO_TARGET_DIRECTORY)/recursion.mk


ALL: _recurse-%-all

all: _recurse-build-all

clean: _recurse-%-clean

$(RECURSE_SLAVES): _recurse-$$@-all


# should provide an easy way how to edit building enviroment's configuration
# which is placed in the .be/config.mk file if you want to edit it manually

config: _force

	$(EDITOR) $(PATH_TO_CONFIG_FILE)
