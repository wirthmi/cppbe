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

#CXX = g++
#AR = ar
#ASTYLE = astyle
#DOXYGEN = doxygen
#VIM = vim


# allows to override selection of text editor made by shell's VISUAL or EDITOR
# variables, if no editor is selected in any way a fallback to Vim will be used

#EDITOR =


# names of final executable binaries separated by spaces, for each executable
# there must be a source file of the same name and with appropriate extension
# containing definition of the main() function, if no executables are given,
# only a static library defined below in BUILD_LIBRARY variable will be built

#BUILD_EXECUTABLES = project


# name of final static library constructed from all object files except the
# ones related to BUILD_EXECUTABLES variable mentioned above

#BUILD_LIBRARY = libproject.a


# allowed extensions for header files separated by vertical bars and single
# extension used for source files

#SRC_HEADER_EXTENSIONS = hpp|tpp
#SRC_SOURCE_EXTENSION = cpp


# astyle rules applicable on header and source files, see a comprehensive
# manual for astyle at http://astyle.sourceforge.net/astyle.html

#SRC_ASTYLE_RULES = \
#	--style=java \
#	--indent=spaces=2 \
#	--attach-namespaces \
#	--attach-classes \
#	--indent-namespaces \
#	--indent-switches \
#	--indent-preproc-define \
#	--indent-preproc-cond \
#	--pad-oper \
#	--pad-paren-in \
#	--pad-header \
#	--align-pointer=middle \
#	--align-reference=middle \
#	--add-brackets \
#	--close-templates \
#	--suffix=none \


# user defined compilator and linker settings including dependencies on some
# external libraries as in OpenCV example below

# notice that everything could be defined globally or just for a specific
# platform, currently GNU/Linux and Cygwin plaforms are well recognized

#CXXFLAGS += -Wall -O3 -std=c++11
#CXXFLAGS += -g -DDEBUG_MODE_

#ifeq "$(BUILD_PLATFORM)" "linux"
#CXXFLAGS += -DWAY_TO_SET_LINUX_SPECIFIC_CXXFLAGS
#endif

#ifeq "$(BUILD_PLATFORM)" "cygwin"
#CXXFLAGS += -DWAY_TO_SET_CYGWIN_SPECIFIC_CXXFLAGS
#endif

#CXXFLAGS += $(shell pkg-config --cflags opencv)
#LDFLAGS += $(shell pkg-config --libs-only-L opencv)
#LDLIBS += $(shell pkg-config --libs-only-l opencv)
