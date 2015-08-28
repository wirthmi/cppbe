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

# usage: $(call FUNCTION_DROP_REDUNDANT_SLASHES,path)
FUNCTION_DROP_REDUNDANT_SLASHES = $(shell echo $(1) | sed 's/\/\/*/\//g')

# usage: $(call FUNCTION_FIND_FILES,directory,filename_regex)
FUNCTION_FIND_FILES = $(shell $(call FUNCTION_GET_FILES_FINDER,$(1),$(2)))

# usage: $(call FUNCTION_GET_FILES_FINDER,directory,filename_regex)
define FUNCTION_GET_FILES_FINDER
\
find $(1) \
	-type f \
	-regextype posix-extended \
	-iregex '^([^/]*/)*$(2)$$' \
	-printf '%P\n'
endef

# usage: $(call FUNCTION_GET_EXTENDED_CXXFLAGS,source_file_path)
define FUNCTION_GET_EXTENDED_CXXFLAGS =
\
$(shell
	echo -n $(CXXFLAGS);
	sed -n '/\/\/\s*CXXFLAGS\s*=/{s/^.*=//;p;q}' $(1)
)
endef


# === CONCEPT OF CLEAN RECORD FILES =========

# they are append only and they help to keep track files produced by the
# building process, when cleaning the environment all object files etc. could
# be easily deleted even if corresponding source files has been already removed

# usage: $(call FUNCTION_ADD_CLEAN_RECORD,any_file_paths)
FUNCTION_ADD_CLEAN_RECORD = $(shell \
	echo $(1) | $(call FUNCTION_GET_CLEAN_RECORD_ADDER) \
)

# usage: $(call FUNCTION_GET_CLEAN_RECORD_ADDER)
define FUNCTION_GET_CLEAN_RECORD_ADDER
\
$(strip awk '
	BEGIN {
		clean_record_file = "$(BUILD_CLEAN_RECORD_FILE)";
		while ( ( getline record < clean_record_file ) > 0 ) {
			records[record] = 0;
		}
	}
	{
		for ( i = 1; i <= NF; ++i ) {
			records[$$i] = 1;
		}
	}
	END {
		for ( record in records ) {
			print record > clean_record_file;
			if ( records[record] == 1 ) {
				print record;
			}
		}
	}
')
endef


# === CONCEPT OF DEPENDENCY FILES =========

# when a dependency file already exists while compiling the object, it should
# be used to decide whether it is necessary to recompile the object or not,
# when dependency file doesn't exist the recompilation is forced because it may
# be necessary to do it, see FUNCTION_GET_OBJECTS_BUILDING_TARGET

# usage: $(call FUNCTION_SOLVE_DEPENDENCIES,dependency_file_path)
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
# 	executable_names_or_empty, \
# 	library_or_object_file_paths_allowing_stem \
# ))
define FUNCTION_GET_EXECUTABLES_BUILDING_TARGET

$(1) DUMMY: %: $(2)
	$(CXX) $(LDFLAGS) $$^ \
		-o $$(call FUNCTION_ADD_CLEAN_RECORD,$$@) $(LDLIBS)
endef

# usage:
# $(eval $(call FUNCTION_GET_LIBRARY_BUILDING_TARGET, \
# 	library_name, \
# 	non_main_object_file_paths_allowing_stem \
# ))
define FUNCTION_GET_LIBRARY_BUILDING_TARGET

$(1): %: $(2)
	$(AR) crvs $$(call FUNCTION_ADD_CLEAN_RECORD,$$@) $$^
endef

# usage:
# $(eval $(call FUNCTION_GET_OBJECTS_BUILDING_TARGET, \
# 	object_file_paths, \
# 	source_file_paths_allowing_stem \
# ))
define FUNCTION_GET_OBJECTS_BUILDING_TARGET

$(1): %.$(BUILD_OBJECT_EXTENSION): \
$(2) \
$$$$(call FUNCTION_SOLVE_DEPENDENCIES,%.$(BUILD_DEPENDENCY_EXTENSION)) \
$(PATH_TO_CONFIG_FILE)

	@ # ensure target path existence
	mkdir -p $$(dir $$@)

	@ # create a dependency file
	@ $(CXX) -MM \
		$$(call FUNCTION_GET_EXTENDED_CXXFLAGS,$$<) \
		$$(call FUNCTION_DROP_REDUNDANT_SLASHES,$$<) \
		| sed -n '1h;1!H;$$$${g;s/^[^:]*://;s/[ \\]/\n/g;p}' \
		| sed '/^$$$$/d;/\.$(SRC_SOURCE_EXTENSION)$$$$/d' \
		> $$(call FUNCTION_ADD_CLEAN_RECORD,$$*.$(BUILD_DEPENDENCY_EXTENSION))

	@ # and compile the object file
	$(CXX) \
		$$(call FUNCTION_GET_EXTENDED_CXXFLAGS,$$<) \
		$$(call FUNCTION_DROP_REDUNDANT_SLASHES,$$<) \
		-o $$(call FUNCTION_ADD_CLEAN_RECORD,$$@)
endef

# usage:
# $(eval $(call FUNCTION_GET_FORCING_SUBMAKES_TARGET, \
# 	list_of_directory_path/target_name_eg_some_file \
# ))
define FUNCTION_GET_FORCING_SUBMAKES_TARGET

$(1): FORCE
	$(MAKE) -C $$(dir $$@) -j $(JOBS) $$(notdir $$@)
endef
