# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

# === BASIC STUFF SECTION =========

SHELL = /bin/bash
JOBS = $(shell nproc)

.DEFAULT_GOAL = all

BE_DIRECTORY = .be/
PATH_TO_ROOT_DIRECTORY = $(patsubst %$(BE_DIRECTORY),%,$(PATH_TO_BE_DIRECTORY))

SNIPPET_DIRECTORY = snippet/
PATH_TO_SNIPPET_DIRECTORY = $(PATH_TO_BE_DIRECTORY)/$(SNIPPET_DIRECTORY)


# === SRC DIRECTORY RELATED SECTION =========

SRC_DIRECTORY = src/
PATH_TO_SRC_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(SRC_DIRECTORY)

SRC_HEADER_EXTENSIONS = hpp|tpp
SRC_SOURCE_EXTENSION = cpp


# === BUILD DIRECTORY RELATED SECTION =========

BUILD_DIRECTORY = build/
PATH_TO_BUILD_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(BUILD_DIRECTORY)

BUILD_DEPENDENCY_EXTENSION = d
BUILD_OBJECT_EXTENSION = o

BUILD_EXECUTABLES = project
BUILD_LIBRARY = libproject.a


# === RUNTIME STUFF SECTION =========

CXX = g++
#CXX = clang
AR = ar
ASTYLE = astyle
DOXYGEN = doxygen

CXXFLAGS = -c -I$(call FUNCTION_DROP_REDUNDANT_SLASHES,$(PATH_TO_SRC_DIRECTORY))
LDFLAGS =
LDLIBS =
