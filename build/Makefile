# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

include ../include.mk

all: $(BUILD_LIBRARY) $(BUILD_EXECUTABLE)

clean:
	rm -f $(BUILD_EXECUTABLE) $(BUILD_LIBRARY) $(DEPENDENCIES) $(OBJECTS)
	find ./ -depth -mindepth 1 -type d -delete

$(BUILD_LIBRARY): $(OBJECTS_EXCEPT_MAIN)
	$(AR) crvs $(BUILD_LIBRARY) $(OBJECTS_EXCEPT_MAIN)

$(BUILD_EXECUTABLE) DUMMY: $(BUILD_MAIN) $(BUILD_LIBRARY)
	$(CXX) $(LDFLAGS) $(BUILD_MAIN) $(BUILD_LIBRARY) -o $@ $(LDLIBS)

# when a dependency file already exists it is used to decide wheter it is necessary
# to recompile the object or not, when dependency file doesn't exist the recompilation
# is forced because it may be necessary

FUNCTION_TRY_LOAD_DEPENDENCIES = \
	$(shell if [ -r $(1) ]; then cat $(1); else echo FORCE; fi)

.SECONDEXPANSION:

$(OBJECTS): %.o: \
$(PATH_TO_SRC_DIRECTORY)/%.$(SRC_SOURCE_SUFFIX) \
$$(call FUNCTION_TRY_LOAD_DEPENDENCIES,%.d)

	@ # ensure target path existence
	mkdir -p $(@D)/

	@ # create a dependency file
	@ $(CXX) -MM $(CXXFLAGS) $(call FUNCTION_DROP_REDUNDANT_SLASHES,$<) | \
		sed -n '1h;1!H;$${g;s/^[^:]*://;s/[ \\]/\n/g;p}' | \
		sed '/^$$/d;/\.$(SRC_SOURCE_SUFFIX)$$/d' > $*.d

	@ # and compile the object file
	$(CXX) $(CXXFLAGS) $(call FUNCTION_DROP_REDUNDANT_SLASHES,$<) -o $*.o

.PHONY: FORCE

FORCE:
