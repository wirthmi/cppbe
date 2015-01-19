# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

include ../../include.mk

CATCH = catch

CATCH_HEADER = $(CATCH).hpp
CATCH_SOURCE = $(CATCH).cpp
CATCH_OBJECT = $(CATCH_SOURCE:.cpp=.o)

TEST_SOURCES = $(call FUNCTION_FIND_FILES,./,test_[a-z_]+\.$(SRC_SOURCE_SUFFIX))
TEST_OBJECTS = $(TEST_SOURCES:.$(SRC_SOURCE_SUFFIX)=.o)

all: run

clean:
	rm -f $(CATCH) $(CATCH_OBJECT) $(TEST_OBJECTS)

run: $(CATCH)
	./$(CATCH) --durations yes

$(CATCH): $(CATCH_OBJECT) $(TEST_OBJECTS) $(PATH_TO_BUILD_LIBRARY)
	$(CXX) $(LDFLAGS) $(CATCH_OBJECT) $(TEST_OBJECTS) $(PATH_TO_BUILD_LIBRARY) -o $@ $(LDLIBS)

$(CATCH_OBJECT) $(TEST_OBJECTS): %.o: %.$(SRC_SOURCE_SUFFIX) $(CATCH_HEADER)
	$(CXX) $(CXXFLAGS) $< -o $*.o

$(PATH_TO_BUILD_LIBRARY): $(addprefix $(PATH_TO_SRC_DIRECTORY)/,$(HEADERS_AND_SOURCES))
	$(MAKE) -C $(PATH_TO_BUILD_DIRECTORY) -j $(JOBS) $(BUILD_LIBRARY)
