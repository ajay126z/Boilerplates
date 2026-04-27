########################################################################
# Paths and locations to enable easy portability
########################################################################

# SW Component name to be tested and its souce code location
COMP_SUM := SUM
DIR_SUM := $(SOURCE_DIR)/$(COMP_SUM)

########################################################################
# File Names and Preparations for Unit Test compilation and execution
########################################################################
# Name of the file to be tested by using the Component Name
OBJ_SUM := Sample_Sum

# Name of the UT file/executable to be created by using UT_ as prefix
TEST_SUM := UT_$(OBJ_SUM)

# Add the name of the target into the overall target dependencies variable for unit test
TARGETNAME += $(TEST_SUM)

# Create the executable command for the output script/exe
EXE_SUM := $(HOMEDIR)/UT_$(OBJ_SUM).out

DEP_SUM := $(TESTCASE_DIR)/$(COMP_SUM)/$(TEST_SUM).cc

########################################################################
# Recipe to Build and Execute the Unit Test
# Note: Due to the Structure of the makefiles, the target ALL is not the first target that make will
#       detect. Make sure to specify the target ALL as default in your compilation process/setup.
########################################################################

all:

# Only rule to execute the Unit Test script/exe of this SE component.
run_$(TEST_SUM): $(TEST_SUM).out
	-./$(TEST_SUM).out

# Create the executable file
$(TEST_SUM).out: $(DEP_SUM) gmock_main.a
	@echo "--> Compiling $(TEST_SUM).o"
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $(TESTCASE_DIR)/$(COMP_SUM)/$(TEST_SUM).cc
	@echo "--> Creating $(TEST_SUM).o"
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -lpthread $^ -o $@