# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

include ../.be/init.mk

all: $(BUILD_EXECUTABLES) $(BUILD_LIBRARY)

clean:
	rm -f $(BUILD_EXECUTABLES) $(BUILD_LIBRARY) $(OBJECTS) $(DEPENDENCIES)
	find ./ -depth -mindepth 1 -type d -delete

$(eval $(call FUNCTION_GET_EXECUTABLES_BUILDING_TARGET, \
	$(BUILD_EXECUTABLES), \
	%.$(BUILD_OBJECT_EXTENSION) $(BUILD_LIBRARY) \
))

$(eval $(call FUNCTION_GET_LIBRARY_BUILDING_TARGET, \
	$(BUILD_LIBRARY), \
	$(OBJECTS_EXCEPT_MAIN) \
))

$(eval $(call FUNCTION_GET_OBJECTS_BUILDING_TARGET, \
	$(OBJECTS), \
	$(PATH_TO_SRC_DIRECTORY)/%.$(SRC_SOURCE_EXTENSION) \
))
