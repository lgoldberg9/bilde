# Makefile to build srslbp
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

BINARYPATH := $(ROOT)/bin

# Build with g++
CXX := g++

# Flags
CXXFLAGS := -std=c++11 -I$(ROOT)/include
LDFLAGS += $(addprefix -l, $(LIBS))

# Source files and target executables
SOURCES := $(wildcard *.cc)
TARGETS := $(basename $(SOURCES))

# Default source and object files
SRCS    ?= $(wildcard *.cc) $(wildcard *.cpp) $(wildcard *.c)
OBJS    ?= $(addprefix obj/,$(patsubst %.cpp,%.o,$(patsubst %.cc,%.o,$(patsubst %.c,%.o,$(SRCS)))))

# Targets to build recursively into $(DIRS)
RECURSIVE_TARGETS  ?= all clean

# If not set, the build path is just the current directory name
MAKEPATH ?= `basename $(PWD)`

# Log the build path in gray, following by a log message in bold green
LOG_PREFIX := "$(shell tput setaf 7)[$(MAKEPATH)]$(shell tput sgr0)$(shell tput setaf 2)"
LOG_SUFFIX := "$(shell tput sgr0)"

# Build all targets by default
all:: $(TARGETS)

# Clean up after a build
clean::
	echo no

.PHONY: all clean

$(TARGETS):
	@echo $(LOG_PREFIX) Compiling $@ $< $(LOG_SUFFIX)
	$(CXX) $(CXXFLAGS) -o $@ $@.cc $(LDFLAGS)

$(RECURSIVE_TARGETS)::
	@for dir in $(DIRS); do \
	$(MAKE) -C $$dir --no-print-directory $@ MAKEPATH="$(MAKEPATH)/$$dir"; \
	done
