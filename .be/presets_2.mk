# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

# a lookup for header and source paths, notice that all of them will be relative
# to the SRC_DIRECTORY and without the "./" prefix
HEADERS = $(call FUNCTION_FIND_FILES,$(PATH_TO_SRC_DIRECTORY),.*\.($(SRC_HEADER_EXTENSIONS)))
SOURCES = $(call FUNCTION_FIND_FILES,$(PATH_TO_SRC_DIRECTORY),.*\.$(SRC_SOURCE_EXTENSION))
HEADERS_AND_SOURCES = $(HEADERS) $(SOURCES)

# derivation of dependency and object paths, similarly they are also relative to
# the BUILD_DIRECTORY and again without the "./" prefix
DEPENDENCIES = $(SOURCES:.$(SRC_SOURCE_EXTENSION)=.$(BUILD_DEPENDENCY_EXTENSION))
OBJECTS = $(SOURCES:.$(SRC_SOURCE_EXTENSION)=.$(BUILD_OBJECT_EXTENSION))
OBJECTS_ONLY_MAIN = $(addsuffix .$(BUILD_OBJECT_EXTENSION),$(BUILD_EXECUTABLES))
OBJECTS_EXCEPT_MAIN = $(filter-out $(OBJECTS_ONLY_MAIN),$(OBJECTS))

# path to final library might be handy
PATH_TO_BUILD_LIBRARY = $(PATH_TO_BUILD_DIRECTORY)/$(BUILD_LIBRARY)
