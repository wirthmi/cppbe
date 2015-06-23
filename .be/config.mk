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

# === RUNTIME STUFF SECTION =========

# various paths to compilator etc., usually they are all reachable from PATH
#CXX = g++
#AR = ar
#ASTYLE = astyle
#DOXYGEN = doxygen
#VIM = vim

# user defined compilator and linker settings
#CXXFLAGS += -Wall -O3 -std=c++11
#CXXFLAGS += -g -DDEBUG_MODE_
#CXXFLAGS += -DSILENT_MODE_

# dependency on external library (e.g. from libopencv-dev)
#CXXFLAGS += $(shell pkg-config --cflags opencv)
#LDFLAGS += $(shell pkg-config --libs-only-L opencv)
#LDLIBS += $(shell pkg-config --libs-only-l opencv)


# === BUILD DIRECTORY RELATED SECTION =========

# names of final executable binaries (separated by spaces), for each executable
# there must be a source file with the same name (and appropriate extension)
# containing a definition of the main() function, if no executables are given,
# only a static library defined below in BUILD_LIBRARY will be built
#BUILD_EXECUTABLES = project

# name of final static library constructed from all object files except the
# ones related to BUILD_EXECUTABLES mentioned above
#BUILD_LIBRARY = libproject.a


# === SRC DIRECTORY RELATED SECTION =========

# used extensions for header files (separated by vertical bars)
#SRC_HEADER_EXTENSIONS = hpp|tpp

# single extension used for source files
#SRC_SOURCE_EXTENSION = cpp

# definition of header and source files code style for astyle tool
#SRC_ASTYLE_OPTIONS = \
#	--style=java \
#	--indent=spaces=2 \
#	--attach-namespaces \
#	--attach-classes \
#	--indent-namespaces \
#	--indent-switches \
#	--pad-oper \
#	--pad-paren-in \
#	--pad-header \
#	--align-pointer=middle \
#	--align-reference=middle \
#	--add-brackets \
#	--close-templates \
#	--suffix=none \
