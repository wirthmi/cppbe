# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

# usage: $(call FUNCTION_GET_SUBSTRING,string,separator,substring_index)
FUNCTION_GET_SUBSTRING = $(word $(3),$(subst $(2), ,$(1)))

# usage: $(call FUNCTION_FIND_FILES,directory,filename_regex)
FUNCTION_FIND_FILES = $(shell \
	find '$(1)' -type f -regextype posix-extended -iregex '^([^/]*/)*$(2)$$' -printf '%P\n' \
)

# usage: $(call FUNCTION_DROP_REDUNDANT_SLASHES,path)
FUNCTION_DROP_REDUNDANT_SLASHES = $(shell echo $(1) |sed 's/\/\/*/\//g')
