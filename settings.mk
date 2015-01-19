# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

# various tools, usually they're all in PATH
CXX = g++
#CXX = clang
AR = ar
ASTYLE = astyle
DOXYGEN = doxygen

# building targets, with empty BUILD_EXECUTABLE and BUILD_MAIN only library will be built
BUILD_DIRECTORY = build/
BUILD_EXECUTABLE = project
BUILD_LIBRARY = libproject.a
BUILD_MAIN = main.o

# user defined compilator and linker settings, essential ones are added later
CXXFLAGS = -Wall -O3 -std=c++11
#CXXFLAGS += -g -DDEBUG_MODE_
#CXXFLAGS += -DSILENT_MODE_
LDFLAGS =
LDLIBS =

# sources placement
SRC_DIRECTORY = src/
SRC_HEADER_SUFFIXES = hpp|tpp
SRC_SOURCE_SUFFIX = cpp

# command which should be used to apply style on a single header or source file
SRC_STYLE_COMMAND = \
	$(ASTYLE) $(1) \
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
		--suffix=none
