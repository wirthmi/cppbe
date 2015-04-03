# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

include ../.be/init.mk

all: $(BUILD_EXECUTABLES) $(BUILD_LIBRARY)

clean:
	rm -f $(BUILD_EXECUTABLES) $(BUILD_LIBRARY) $(OBJECTS) $(DEPENDENCIES)
	find ./ -depth -mindepth 1 -type d -delete

$(BUILD_EXECUTABLES) DUMMY: %: %.$(BUILD_OBJECT_EXTENSION) $(BUILD_LIBRARY)
	$(CXX) $(LDFLAGS) $^ -o $@ $(LDLIBS)

$(BUILD_LIBRARY): $(OBJECTS_EXCEPT_MAIN)
	$(AR) crvs $@ $^

.SECONDEXPANSION:

$(OBJECTS): %.$(BUILD_OBJECT_EXTENSION): \
$(PATH_TO_SRC_DIRECTORY)/%.$(SRC_SOURCE_EXTENSION) \
$$(call FUNCTION_SOLVE_DEPENDENCIES,%.$(BUILD_DEPENDENCY_EXTENSION))

	@ # ensure target path existence
	mkdir -p $(dir $@)

	@ # create a dependency file
	@ $(CXX) -MM $(CXXFLAGS) $(call FUNCTION_DROP_REDUNDANT_SLASHES,$<) | \
		$(call FUNCTION_GET_DEPENDENCY_FILE_FORMATTER,$(SRC_SOURCE_EXTENSION)) > \
		$*.$(BUILD_DEPENDENCY_EXTENSION)

	@ # and compile the object file
	$(CXX) $(CXXFLAGS) $(call FUNCTION_DROP_REDUNDANT_SLASHES,$<) -o $@
