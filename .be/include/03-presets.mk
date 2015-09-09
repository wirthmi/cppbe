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


# paths to required tools, they're usually reachable from shell's PATH variable

CXX = g++
#CXX = clang++
AR = ar
ASTYLE = astyle
DOXYGEN = doxygen
VIM = vim


# text editor is later selected preferentially in accordance with build
# environment's configuration, shell's VISUAL and EDITOR variables or with last
# fallback to Vim

EDITOR =


# following flags could be sucessively built during initialization until final
# usage, e.g. the get_extended_cxxflags function is being used as the last step
# instead of using CXXFLAGS variable directly in compilator calls

CXXFLAGS = -c
LDFLAGS =
LDLIBS =


# stuff related to the build/ directory

BUILD_DIRECTORY = build/
PATH_TO_BUILD_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(BUILD_DIRECTORY)

BUILD_PLATFORM = $(call detect_platform)

BUILD_CLEANUP_FILE = .becleanup

BUILD_DEPENDENCY_EXTENSION = d
BUILD_OBJECT_EXTENSION = o

BUILD_EXECUTABLES = project
BUILD_LIBRARY = libproject.a


# stuff related to the src/ directory

SRC_DIRECTORY = src/
PATH_TO_SRC_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(SRC_DIRECTORY)

CXXFLAGS += -I$(call strip_slashes,$(PATH_TO_SRC_DIRECTORY))

SRC_HEADER_EXTENSIONS = hpp|tpp
SRC_SOURCE_EXTENSION = cpp

SRC_ASTYLE_RULES = \
	--style=java \
	--indent=spaces=2 \
	--attach-namespaces \
	--attach-classes \
	--indent-namespaces \
	--indent-switches \
	--indent-preproc-define \
	--indent-preproc-cond \
	--pad-oper \
	--pad-paren-in \
	--pad-header \
	--align-pointer=middle \
	--align-reference=middle \
	--add-brackets \
	--close-templates \
	--suffix=none \


# stuff related to the include/ directory

INCLUDE_DIRECTORY = include/
PATH_TO_INCLUDE_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(INCLUDE_DIRECTORY)

CXXFLAGS += -I$(call strip_slashes,$(PATH_TO_INCLUDE_DIRECTORY))


# stuff related to the lib/ directory

LIB_DIRECTORY = lib/
PATH_TO_LIB_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(LIB_DIRECTORY)


# stuff related to the data/ directory

DATA_DIRECTORY = data/
PATH_TO_DATA_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(DATA_DIRECTORY)
