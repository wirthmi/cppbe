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


# usage: $(call trim,string_with_leading_or_trailing_whitespace)

define trim
$(shell
	echo '$(1)' | sed 's/^\s*//;s/\s*$$//'
)
endef


# usage: $(call cut,delimiter,field,string_consisting_of_fields)

define cut
$(shell
	echo '$(3)' | cut -d '$(1)' -f '$(2)'
)
endef


# usage: $(call strip_slashes,path_with_redundant_slashes)

define strip_slashes
$(shell
	echo '$(1)' | sed 's/\/\/*/\//g'
)
endef


# usage: $(call prettify_path,path_with_ugly_itches)

define prettify_path
$(call strip_slashes,$(shell
	echo $(1)
	| sed -r 's#(^|/)(\./)+#\1#g'
	| sed -r 's#(^|/)\.$$#\1#'
	| sed -r ':A;{s#(^|/)((\.[^/.][^/]*)|([^/.][^/]*))/\.\.(/|$$)#\1#;tA}'
))
endef


# usage: $(call filter_by_regexp,regexp,words)

define filter_by_regexp
$(shell
	echo '$(2)'
		| tr ' ' '\n'
		| grep -E '$(call trim,$(1))'
		| paste -s -d ' '
)
endef


# usage: $(call find_by_regexp,path_to_directory,regexp)

define find_by_regexp
$(shell
	$(call get_regexp_finder,$(1),$(2))
)
endef


# usage: $(call get_regexp_finder,path_to_directory,regexp)

define get_regexp_finder
find $(1)
	-type f
	-regextype posix-extended
	-iregex '^([^/]*/)*$(call trim,$(2))$$'
	-printf '%P\n'
endef


# usage: $(call get_extended_cxxflags,path_to_source_file)

define get_extended_cxxflags
$(shell
	echo -n '$(CXXFLAGS)';
	sed -n '/\/\/\s*CXXFLAGS\s*=/{s/^.*=//;p;q}' $(1)
)
endef


# usage: $(call detect_platform)

define detect_platform
$(shell
	uname -o
		| tr '[:upper:]' '[:lower:]'
		| sed 's/^.*\(\(linux\)\|\(cygwin\)\).*$$/\1/'
)
endef


# cleanup files are append only and help to track files produced by building
# processes, when cleaning the environment all object files etc. could be
# easily deleted even if corresponding source files has been already removed

# usage: $(call register_cleanup,paths_to_any_files)

define register_cleanup
$(shell
	echo $(1) | $(call get_cleanup_registrar)
)
endef


# usage: $(call get_cleanup_registrar)

define get_cleanup_registrar
$(strip awk '
	BEGIN {
		cleanup_file = "$(BUILD_CLEANUP_FILE)";
		while ( ( getline cleanup < cleanup_file ) > 0 ) {
			cleanups[cleanup] = 0;
		}
	}
	{
		for ( i = 1; i <= NF; ++i ) {
			cleanups[$$i] = 1;
		}
	}
	END {
		for ( cleanup in cleanups ) {
			print cleanup > cleanup_file;
			if ( cleanups[cleanup] == 1 ) {
				print cleanup;
			}
		}
	}
')
endef


# dependency files help to track dependencies that are crucial for each object
# file, if appropriate dependency file already exists during building process
# it should be used to decide whether it's really necessary to recompile related
# object file or not, when dependency file doesn't exist the recompilation is
# forced because it may be necessary to do it

# usage: $(call get_resolved_dependencies,path_to_dependency_file)

define get_resolved_dependencies
$(shell
	if [ ! -r $(1) ]; then
		echo _force;
	else
		while read dependency; do
			if [ -r $${dependency} ]; then
				echo $${dependency};
			fi;
		done < $(1);
	fi
	| paste -s -d ' '
)
endef
