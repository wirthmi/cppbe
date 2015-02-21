# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

include ../include.mk

all: $(BUILD_LIBRARY) $(BUILD_EXECUTABLE)

clean:
	rm -f $(BUILD_EXECUTABLE) $(BUILD_LIBRARY) $(OBJECTS) $(DEPENDENCIES)
	find ./ -depth -mindepth 1 -type d -delete

$(BUILD_LIBRARY): $(OBJECTS_EXCEPT_MAIN)
	$(AR) crvs $(BUILD_LIBRARY) $(OBJECTS_EXCEPT_MAIN)

$(BUILD_EXECUTABLE) DUMMY: $(BUILD_MAIN) $(BUILD_LIBRARY)
	$(CXX) $(LDFLAGS) $(BUILD_MAIN) $(BUILD_LIBRARY) -o $@ $(LDLIBS)

.SECONDEXPANSION:

$(OBJECTS): %.o: \
$(PATH_TO_SRC_DIRECTORY)/%.$(SRC_SOURCE_SUFFIX) \
$$(call FUNCTION_SOLVE_DEPENDENCIES,%.d)

	@ # ensure target path existence
	mkdir -p $(@D)/

	@ # create a dependency file
	@ $(CXX) -MM $(CXXFLAGS) $(call FUNCTION_DROP_REDUNDANT_SLASHES,$<) | \
		$(call FUNCTION_GET_DEPENDENCY_FILE_FORMATTER,$(SRC_SOURCE_SUFFIX)) > $*.d

	@ # and compile the object file
	$(CXX) $(CXXFLAGS) $(call FUNCTION_DROP_REDUNDANT_SLASHES,$<) -o $*.o
