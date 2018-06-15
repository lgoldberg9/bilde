# Makefile for building BILDE executables

#   Template lifted from Charlie Curtsinger's Makefile from CSC213/S18 Coursework on 6/15/2018
#   Edited by Logan Goldberg and Jerod Weinman on 6/15/2018

# Cannot locate these libraries. Doesn't seem to interfere with the process.
# opencv_shape
# opencv_videoio
# opencv_imgcodecs
# comctl32
# comdlg32
# gdi32
# ole32
# setupapi
# ws2_32
# vfw32
# strmiids
# winmm
# glu32
# opengl32
# oleaut32

BINPATH := $(ROOT)/bin

# Build with g++
CXX := g++

# Flags
CXXFLAGS := -std=c++11
CPPFLAGS := -I$(ROOT)/include
LDFLAGS += $(addprefix -l, $(LIBS))

# Source files and target executables
TARGETS := $(basename $(SOURCES))

# Targets to build recursively into $(DIRS)
RECURSIVE_TARGETS ?= all test

# If not set, the build path is just the current directory name
MAKEPATH ?= `basename $(PWD)`

# Log the build path in gray, following by a log message in bold green
LOG_PREFIX := "$(shell tput setaf 7)[$(MAKEPATH)]$(shell tput sgr0)$(shell tput setaf 2)"
LOG_SUFFIX := "$(shell tput sgr0)"

# Build all targets by default
all:: $(TARGETS)

# Clean up after a build
clean::
	rm $(BINPATH)/*

test::


.PHONY: all clean test

$(TARGETS):
	@echo $(LOG_PREFIX) Compiling $@ $(LOG_SUFFIX)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -o $(BINPATH)/$@ $(addsuffix .cc, $@) $(LDFLAGS)

$(RECURSIVE_TARGETS)::
	@for dir in $(DIRS); do \
	$(MAKE) -C $$dir --no-print-directory $@ MAKEPATH="$(MAKEPATH)/$$dir"; \
	done
