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


_DEPENDENCY_FILE = sample.$(BUILD_DEPENDENCY_EXTENSION)

$(info $(and \
	$(shell echo Makefile >> $(_DEPENDENCY_FILE)) \
	$(shell echo test_get_resolved_dependencies.mk >> $(_DEPENDENCY_FILE)) \
	$(shell echo ../not/existing/dependency.foo >> $(_DEPENDENCY_FILE)) \
,))

ifneq \
"$(call get_resolved_dependencies,$(_DEPENDENCY_FILE))" \
"Makefile test_get_resolved_dependencies.mk"
$(warning failed: \
	get_resolved_dependencies > filters out not existing dependencies \
)
endif

$(info $(and \
	$(shell rm -f $(_DEPENDENCY_FILE)) \
,))


ifneq \
"$(call get_resolved_dependencies,missing.$(BUILD_DEPENDENCY_EXTENSION))" \
"_force"
$(warning failed: \
	get_resolved_dependencies > returns _force for missing dependency file \
)
endif
