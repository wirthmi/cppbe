# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

# usage: $(call FUNCTION_GET_SUBSTRING,string,separator,substring_index)
FUNCTION_GET_SUBSTRING = $(word $(3),$(subst $(2), ,$(1)))

# usage: $(call FUNCTION_FIND_FILES,directory,filename_regex)
FUNCTION_FIND_FILES = $(shell \
	find '$(1)' -type f -regextype posix-extended -iregex '^([^/]*/)*$(2)$$' -printf '%P\n' \
)

# usage: $(call FUNCTION_DROP_REDUNDANT_SLASHES,path)
FUNCTION_DROP_REDUNDANT_SLASHES = $(shell echo $(1) |sed 's/\/\/*/\//g')


# === CONCEPT OF DEPENDENCY FILES =========

# when a dependency file already exists while compiling the object, it should
# be used to decide whether it is necessary to recompile the object or not,
# when dependency file doesn't exist the recompilation is forced because it may
# be necessary to do it

# usage: $(call FUNCTION_SOLVE_DEPENDENCIES,dependency_file)
FUNCTION_SOLVE_DEPENDENCIES = $(shell \
	if [ -r $(1) ]; then cat $(1); else echo FORCE; fi \
)

# usage: $(call FUNCTION_GET_DEPENDENCY_FILE_FORMATTER,source_suffix)
FUNCTION_GET_DEPENDENCY_FILE_FORMATTER = \
	sed -n '1h;1!H;$${g;s/^[^:]*://;s/[ \\]/\n/g;p}' | \
	sed '/^$$/d;/\.$(1)$$/d'
