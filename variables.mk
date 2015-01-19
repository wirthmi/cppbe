# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

JOBS = $(shell nproc)

PATH_TO_BUILD_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(BUILD_DIRECTORY)
PATH_TO_SRC_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(SRC_DIRECTORY)

PATH_TO_BUILD_LIBRARY = $(PATH_TO_BUILD_DIRECTORY)/$(BUILD_LIBRARY)
PATH_TO_BUILD_EXECUTABLE = $(PATH_TO_BUILD_DIRECTORY)/$(BUILD_EXECUTABLE)

# notice that all found paths are relative to the SRC_DIRECTORY without the ./ prefix
HEADERS = $(call FUNCTION_FIND_FILES,$(PATH_TO_SRC_DIRECTORY),.*\.($(SRC_HEADER_SUFFIXES)))
SOURCES = $(call FUNCTION_FIND_FILES,$(PATH_TO_SRC_DIRECTORY),.*\.$(SRC_SOURCE_SUFFIX))
HEADERS_AND_SOURCES = $(HEADERS) $(SOURCES)

# similarly dependency and object paths are also relative to the BUILD_DIRECTORY
# and again without the ./ prefix
DEPENDENCIES = $(SOURCES:.$(SRC_SOURCE_SUFFIX)=.d)
OBJECTS = $(SOURCES:.$(SRC_SOURCE_SUFFIX)=.o)
OBJECTS_EXCEPT_MAIN = $(filter-out $(BUILD_MAIN),$(OBJECTS))

# finally set essential compilation flags
CXXFLAGS += -c -I$(call FUNCTION_DROP_REDUNDANT_SLASHES,$(PATH_TO_SRC_DIRECTORY))
