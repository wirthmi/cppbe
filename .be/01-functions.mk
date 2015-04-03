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
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

# usage: $(call FUNCTION_GET_SUBSTRING,string,separator,substring_index)
FUNCTION_GET_SUBSTRING = $(word $(3),$(subst $(2), ,$(1)))

# usage: $(call FUNCTION_FIND_FILES,directory,filename_regex)
FUNCTION_FIND_FILES = $(shell \
	find $(1) \
		-type f \
		-regextype posix-extended \
		-iregex '^([^/]*/)*$(2)$$' \
		-printf '%P\n' \
)

# usage: $(call FUNCTION_DROP_REDUNDANT_SLASHES,path)
FUNCTION_DROP_REDUNDANT_SLASHES = $(shell echo $(1) |sed 's/\/\/*/\//g')


# === CONCEPT OF DEPENDENCY FILES =========

# when a dependency file already exists while compiling the object, it should
# be used to decide whether it is necessary to recompile the object or not,
# when dependency file doesn't exist the recompilation is forced because it may
# be necessary to do it, see FUNCTION_GET_OBJECTS_BUILDING_TARGET

# usage: $(call FUNCTION_SOLVE_DEPENDENCIES,dependency_file)
FUNCTION_SOLVE_DEPENDENCIES = $(shell \
	if [ -r $(1) ]; then cat $(1); else echo FORCE; fi \
)


# === CONCEPT OF SHARED TARGETS =========

# there are two types of shared targets (i.e. reusable targets for several
# Makefiles), first of all configurable targets which are defined here as
# evaluable functions and secondly just-include targets that are kept as
# separate files in the TARGET_DIRECTORY

# usage:
# $(eval $(call FUNCTION_GET_EXECUTABLES_BUILDING_TARGET, \
# 	executable_name_or_empty, \
# 	library_or_object_file_paths_allowing_stem \
# ))
define FUNCTION_GET_EXECUTABLES_BUILDING_TARGET

$(1) DUMMY: %: $(2)
	$(CXX) $(LDFLAGS) $$^ -o $$@ $(LDLIBS)
endef

# usage:
# $(eval $(call FUNCTION_GET_LIBRARY_BUILDING_TARGET, \
# 	library_name, \
# 	non_main_object_file_paths_allowing_stem \
# ))
define FUNCTION_GET_LIBRARY_BUILDING_TARGET

$(1): %: $(2)
	$(AR) crvs $$@ $$^
endef

# usage:
# $(eval $(call FUNCTION_GET_OBJECTS_BUILDING_TARGET, \
# 	object_file_paths, \
# 	source_file_paths_allowing_stem \
# ))
define FUNCTION_GET_OBJECTS_BUILDING_TARGET

$(1): %.$(BUILD_OBJECT_EXTENSION): \
$(2) \
$$(call FUNCTION_SOLVE_DEPENDENCIES,%.$(BUILD_DEPENDENCY_EXTENSION))

	@ # ensure target path existence
	mkdir -p $$(dir $$@)

	@ # create a dependency file
	@ $(CXX) -MM $(CXXFLAGS) $$(call FUNCTION_DROP_REDUNDANT_SLASHES,$$<) \
		| sed -n '1h;1!H;$$$${g;s/^[^:]*://;s/[ \\]/\n/g;p}' \
		| sed '/^$$$$/d;/\.$(SRC_SOURCE_EXTENSION)$$$$/d' \
		> $$*.$(BUILD_DEPENDENCY_EXTENSION)

	@ # and compile the object file
	$(CXX) $(CXXFLAGS) $$(call FUNCTION_DROP_REDUNDANT_SLASHES,$$<) -o $$@
endef

# usage:
# $(eval $(call FUNCTION_GET_FORCING_MAKE_TARGET, \
# 	directory_path/target_name_ie_some_file \
# ))
define FUNCTION_GET_FORCING_MAKE_TARGET

$(1): FORCE
	$(MAKE) -C $$(dir $$@) -j $(JOBS) $$(notdir $$@)
endef
