# Smart GNU Make based build environment for C++.
# Copyright (C) 2015-2016  Michal Wirth <wirthmi@rankl.cz>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

# see http://www.gnu.org/software/make/manual/make.html for Makefile syntax


include ../.be/init.mk
include $(PATH_TO_BE_TARGET_DIRECTORY)/clean.mk


_REFERENCE_HTML_FILE = reference.html


all: $(_REFERENCE_HTML_FILE)

clean: _clean


$(_REFERENCE_HTML_FILE): _CONFIG_FILE = doxygen.conf
$(_REFERENCE_HTML_FILE): _HTML_DIRECTORY = html/

$(_REFERENCE_HTML_FILE): \
\
	$$(_CONFIG_FILE) \
	$(PATHS_TO_SRC_HEADER_FILES) \
	$(PATHS_TO_SRC_SOURCE_FILES)

	$(DOXYGEN) $(_CONFIG_FILE)

	rm -f doxygen_*.db

	ln -sf \
		$(call prettify_path,$(_HTML_DIRECTORY)/index.html) \
		$(call register_cleanup,$(_REFERENCE_HTML_FILE))

	@ $(call get_regexp_finder,$(_HTML_DIRECTORY),.*) \
	| sed 's#^#$(_HTML_DIRECTORY)/#' \
	| $(call get_cleanup_registrar) \
	> /dev/null
