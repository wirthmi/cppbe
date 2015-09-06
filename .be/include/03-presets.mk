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

# === BASIC STUFF SECTION =========

SHELL = /bin/bash
JOBS = $(shell nproc)

.DEFAULT_GOAL = all

BE_DIRECTORY = .be/
PATH_TO_ROOT_DIRECTORY = $(patsubst %$(BE_DIRECTORY),%,$(PATH_TO_BE_DIRECTORY))

TARGET_DIRECTORY = target/
PATH_TO_TARGET_DIRECTORY = $(PATH_TO_BE_DIRECTORY)/$(TARGET_DIRECTORY)

CONFIG_FILE = config.mk
PATH_TO_CONFIG_FILE = $(PATH_TO_BE_DIRECTORY)/$(CONFIG_FILE)


# === SRC DIRECTORY RELATED SECTION =========

SRC_DIRECTORY = src/
PATH_TO_SRC_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(SRC_DIRECTORY)

SRC_HEADER_EXTENSIONS = hpp|tpp
SRC_SOURCE_EXTENSION = cpp

SRC_ASTYLE_OPTIONS = \
	--style=java \
	--indent=spaces=2 \
	--attach-namespaces \
	--attach-classes \
	--indent-namespaces \
	--indent-switches \
	--pad-oper \
	--pad-paren-in \
	--pad-header \
	--align-pointer=middle \
	--align-reference=middle \
	--add-brackets \
	--close-templates \
	--suffix=none \


# === BUILD DIRECTORY RELATED SECTION =========

BUILD_DIRECTORY = build/
PATH_TO_BUILD_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(BUILD_DIRECTORY)

BUILD_CLEAN_RECORD_FILE = .beclean

BUILD_DEPENDENCY_EXTENSION = d
BUILD_OBJECT_EXTENSION = o

BUILD_EXECUTABLES = project
BUILD_LIBRARY = libproject.a


# === INCLUDE DIRECTORY RELATED SECTION =========

INCLUDE_DIRECTORY = include/
PATH_TO_INCLUDE_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(INCLUDE_DIRECTORY)


# === LIB DIRECTORY RELATED SECTION =========

LIB_DIRECTORY = lib/
PATH_TO_LIB_DIRECTORY = $(PATH_TO_ROOT_DIRECTORY)/$(LIB_DIRECTORY)


# === RUNTIME STUFF SECTION =========

CXX = g++
#CXX = clang++
AR = ar
ASTYLE = astyle
DOXYGEN = doxygen
VIM = vim

# notice that all flags are sucessively built during initialization until final
# usage, the FUNCTION_GET_EXTENDED_CXXFLAGS should be used as the last step
# instead of using CXXFLAGS variable directly in compilator call

CXXFLAGS =
LDFLAGS =
LDLIBS =

CXXFLAGS += -c
CXXFLAGS += -I$(call FUNCTION_DROP_REDUNDANT_SLASHES,$(PATH_TO_SRC_DIRECTORY))
CXXFLAGS += -I$(call FUNCTION_DROP_REDUNDANT_SLASHES,$(PATH_TO_INCLUDE_DIRECTORY))
