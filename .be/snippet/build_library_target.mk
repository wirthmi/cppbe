# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax

$(PATH_TO_BUILD_LIBRARY): FORCE
	$(MAKE) -C $(PATH_TO_BUILD_DIRECTORY) -j $(JOBS) $(BUILD_LIBRARY)
