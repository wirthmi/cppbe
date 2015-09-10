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


# notice that there are two types of shared targets (i.e. reusable targets for
# several Makefiles), first of all there are configurable targets which are
# defined here as evaluable functions, and there are also just-include targets
# that are kept as separate files within the .be/target/ directory


# usage: $(eval $(call place_make_slaves_target, \
# 	slave_directory/target_name_pairs \
# ))

define place_make_slaves_target

$(eval _1 = $(call map,prettify_path,$(1)))

$(_1): _SLAVE = $$(dir $$@)
$(_1): _TARGET = $$(notdir $$@)

$(_1): _force

	@ $(MAKE) -C $$(_SLAVE)/ $$(_TARGET)

endef


# usage: $(eval $(call place_executable_files_building_target, \
# 	zero_or_more_paths_to_executable_files, \
# 	paths_to_library_files_allowing_stem, \
# 	paths_to_object_files_allowing_stem, \
# ))

define place_executable_files_building_target

$(eval _1 = $(call map,prettify_path,$(1)))

$(_1) _dummy: _LIBRARY_FILES = $$(call map,prettify_path,$(2))
$(_1) _dummy: _OBJECT_FILES = $$(call map,prettify_path,$(3))
$(_1) _dummy: _EXECUTABLE_FILE = $$@

$(_1) _dummy: %: $$$$(_LIBRARY_FILES) $$$$(_OBJECT_FILES)

	$(CXX) \
		$(LDFLAGS) \
		$$(_OBJECT_FILES) \
		-o $$(call register_cleanup,$$(_EXECUTABLE_FILE)) \
		$$(_LIBRARY_FILES) \
		$(LDLIBS)

endef


# usage: $(eval $(call place_library_file_building_target, \
# 	path_to_library_file, \
# 	paths_to_object_files \
# ))

define place_library_file_building_target

$(eval _1 = $(call prettify_path,$(1)))

$(_1): _OBJECT_FILES = $(call map,prettify_path,$(2))
$(_1): _LIBRARY_FILE = $$@

$(_1): $$$$(_OBJECT_FILES)

	$(AR) crvs \
		$$(call register_cleanup,$$(_LIBRARY_FILE)) $$(_OBJECT_FILES)

endef


# usage: $(eval $(call place_object_files_building_target, \
# 	paths_to_object_files, \
# 	path_to_source_directory \
# ))

define place_object_files_building_target

$(eval _1 = $(call map,prettify_path,$(1)))

$(_1): _SOURCE_DIRECTORY = $(call prettify_path,$(or $(call trim,$(2)),.)/)

$(_1): _SOURCE_FILE = $$(_SOURCE_DIRECTORY)$$*.$(SRC_SOURCE_EXTENSION)
$(_1): _DEPENDENCY_FILE = $$*.$(BUILD_DEPENDENCY_EXTENSION)
$(_1): _OBJECT_FILE = $$@

$(_1): _CXXFLAGS = $$(call get_extended_cxxflags,$$(_SOURCE_FILE))

$(_1): %.$(BUILD_OBJECT_EXTENSION): \
\
	$$$$(_SOURCE_FILE) \
	$$$$(call get_resolved_dependencies,$$$$(_DEPENDENCY_FILE)) \
	$(PATH_TO_BE_CONFIG_FILE)

	mkdir -p $$(dir $$(_OBJECT_FILE))

	@ $(CXX) -MM $$(_CXXFLAGS) $$(_SOURCE_FILE) \
	| sed -n '1h;1!H;$$$${g;s/^[^:]*://;s/[ \\]/\n/g;p}' \
	| sed '/^$$$$/d;/\.$(SRC_SOURCE_EXTENSION)$$$$/d' \
	| sort -u \
	> $$(call register_cleanup,$$(_DEPENDENCY_FILE))

	$(CXX) $$(_CXXFLAGS) \
		$$(_SOURCE_FILE) -o $$(call register_cleanup,$$(_OBJECT_FILE))

endef
