# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

include ../../include.mk

TEST_SOURCES = $(call FUNCTION_FIND_FILES,./,test_[a-z_]+\.$(SRC_SOURCE_SUFFIX))
TEST_OBJECTS = $(TEST_SOURCES:.$(SRC_SOURCE_SUFFIX)=.o)
TEST_EXECUTABLES = $(TEST_OBJECTS:.o=)

all: $(TEST_EXECUTABLES)

clean:
	rm -f $(TEST_EXECUTABLES) $(TEST_OBJECTS)

$(TEST_EXECUTABLES): %: %.o $(PATH_TO_BUILD_LIBRARY)
	$(CXX) $(LDFLAGS) $< $(PATH_TO_BUILD_LIBRARY) -o $@ $(LDLIBS)

$(TEST_OBJECTS): %.o: %.$(SRC_SOURCE_SUFFIX)
	$(CXX) $(CXXFLAGS) $< -o $*.o

$(PATH_TO_BUILD_LIBRARY): $(addprefix $(PATH_TO_SRC_DIRECTORY)/,$(HEADERS_AND_SOURCES))
	$(MAKE) -C $(PATH_TO_BUILD_DIRECTORY) -j $(JOBS) $(BUILD_LIBRARY)
