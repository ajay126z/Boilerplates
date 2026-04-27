
#############################################
# Directories
#############################################

HOMEDIR = .

SOURCE_DIR = $(HOMEDIR)/../Source

TESTCASE_DIR := $(HOMEDIR)/01_test_cases
TESTOUT_DIR := $(HOMEDIR)/02_output
TESTREPORT_DIR := $(HOMEDIR)/03_reports
TESTSTUBS_DIR := $(HOMEDIR)/04_stubs
TESTMAKE_DIR := $(HOMEDIR)/05_makefiles


# Point to the root of Google Test, relative to where this file is.
TOOLS_DIR = $(HOMEDIR)/../Tools
GTESTTOOL = $(TOOLS_DIR)/googletest
GTEST_DIR = $(GTESTTOOL)

# Point to the root of Google Mock, relative to where this file is.
GMOCKTOOL = $(TOOLS_DIR)/googlemock
GMOCK_DIR = $(GMOCKTOOL)
GMOCK_TEST_DIR = $(GMOCKTOOL)/test

#############################################
# Compiler Options
#############################################

COMPILER = clang++
STD = -std=c++17
CXX = $(COMPILER) $(STD)
AR = ar
ARFLAGS = -ruc

# Flag passed to the C++ compiler
CXXWARN := -w #-Wall -Wextra
CXXFLAGS := -g $(CXXWARN) -pthread --coverage -Wa, -fpermissive -O
#CXXFLAGS := -g $(CXXWARN) $(CMACROS) -pthread --coverage -Wa, -mbig-obj -fpermissive -O

GMAKE := +$(MAKE) -f RunTests.mk

####################################################################################################
# All Google Test Headers. Usually you shouldn't change this definition.
####################################################################################################

GTEST_HEADERS = $(GTEST_DIR)/include/gtest/*.h \
				$(GTEST_DIR)/include/gtest/internal/*.h 

# All Google Mock Headers. 
# Note that all Google Test headers are included here too, as they are included by Google Mock headers.
#Usually you shouldn't change this definition.
GMOCK_HEADERS = $(GMOCK_DIR)/include/gmock/*.h \
				$(GMOCK_DIR)/include/gmock/internal/*.h \
				$(GTEST_HEADERS)

# Include Folders
VPATH += $(SOURCE_DIR)/*
VPATH_DIRECTORIES := $(wildcard $(subst :, ,$(VPATH)))
INCLUDE_DIRECTORIES := $(addprefix -I, $(VPATH_DIRECTORIES))

# Place the Source Path into CPP Flags

CPPFLAGS := $(INCLUDE_DIRECTORIES)

CPPFLAGS += -I$(GTEST_DIR)/include -I$(GTEST_DIR)/include/gtest
CPPFLAGS += -I$(GMOCK_DIR)/include -I$(GMOCK_DIR)/include/gmock

#############################################
# Command Support for easier Portability
#############################################
RM := -rm -f
RRM := -rm -f -r
MOVE := -mv -f
CP := -cp


####################################################################################################
# Include all Unit Test makefiles.
# NOTE: The compilation of each Unit Test is made inside its makefile.
####################################################################################################

include $(TESTMAKE_DIR)/make_Sample_Sum.mk
include $(TESTMAKE_DIR)/make_Sample_Mul.mk

####################################################################################################
# Recipe to build and execute the Unit Test.
# NOTE: Due to the Structure of the makefiles, the target ALL is not the first target that make will
#       detect. Make sure to specify the target ALL as default in your compilation process/setup.
####################################################################################################
.PHONY: all
all: gmock_main.a gmock_test.o
	@echo "---> GTEST Compilation"
	@$(GMAKE) $(TARGETNAME)
	@echo "---> Moving Stuffs"
	@$(GMAKE) move_all

.PHONY:clean
clean:
	$(RM) *.o
	$(RM) *.gcno
	$(RM) *.a
	$(RM) *.gcda
	$(RM) *.out

.PHONY:move_all
move_all:
	@echo "--> Moving files post run."
	@$(MOVE) *.o $(TESTOUT_DIR)
	@$(MOVE) *.a $(TESTOUT_DIR)
	@$(MOVE) *.gcno $(TESTREPORT_DIR)
	@$(MOVE) *.gcda $(TESTREPORT_DIR)
	@$(MOVE) *.out $(TESTREPORT_DIR)

####################################################################################################
# Build gtest.a and gtest_mock.a
####################################################################################################

# Builds gmock.a and gmock_main.a. These libraries contain both Google Test and Google Mock. 
# A test should link with either gmock.a or gmock_main, depending on whether it defines its own main()
# function. It's fine if your test only uses features from Google Test (and not Google Mock).
# Usually you shouldn't tweak such internal variables, indicated by a trailing _.

GTEST_SRCS_ = $(GTEST_DIR)/src/*.cc $(GTEST_DIR)/src/*.h $(GTEST_HEADERS)
GMOCK_SRCS_ = $(GMOCK_DIR)/src/*.cc $(GMOCK_HEADERS)

# For simplicity and to avoid depending on implementation details of Google Mock and Google Test, the 
# dependencies specified below are conservative and not optimized. This is fine as Google Mock and 
# Google Test compile fast and for ordinary users their source rarely changes.
gtest-all.o: $(GTEST_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) -I$(GMOCK_DIR) $(CXXFLAGS) -c $(GTEST_DIR)/src/gtest-all.cc

gmock-all.o: $(GMOCK_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) -I$(GMOCK_DIR) $(CXXFLAGS) -c $(GMOCK_DIR)/src/gmock-all.cc


gmock_main.o: $(GMOCK_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) -I$(GMOCK_DIR) $(CXXFLAGS) -c $(GMOCK_DIR)/src/gmock_main.cc

gmock.a: gmock-all.o gtest-all.o
	$(AR) $(ARFLAGS) $@ $^

gmock_main.a: gmock-all.o gtest-all.o gmock_main.o
	$(AR) $(ARFLAGS) $@ $^

gmock_test.o: $(GMOCK_TEST_DIR)/gmock_test.cc $(GMOCK_HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $(GMOCK_TEST_DIR)/gmock_test.cc