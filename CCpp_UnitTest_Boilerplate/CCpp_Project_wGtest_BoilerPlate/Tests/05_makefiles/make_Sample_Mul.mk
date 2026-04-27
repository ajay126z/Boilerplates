########################################################################
# Paths and locations to enable easy portability
########################################################################

# SW Component name to be tested and its souce code location
COMP_MUL := MUL
DIR_MUL := $(SOURCE_DIR)/$(COMP_MUL)

########################################################################
# File Names and Preparations for Unit Test compilation and execution
########################################################################
# Name of the file to be tested by using the Component Name
OBJ_MUL := Sample_Mul

# Name of the UT file/executable to be created by using UT_ as prefix
TEST_MUL := UT_$(OBJ_MUL)

# Add the name of the target into the overall target dependencies variable for unit test
TARGETNAME += $(TEST_MUL)

# Create the executable command for the output script/exe
EXE_MUL := $(HOMEDIR)/UT_$(OBJ_MUL).out

DEP_MUL := $(TESTCASE_DIR)/$(COMP_MUL)/$(TEST_MUL).cc

########################################################################
# Recipe to Build and Execute the Unit Test
# Note: Due to the Structure of the makefiles, the target ALL is not the first target that make will
#       detect. Make sure to specify the target ALL as default in your compilation process/setup.
########################################################################

all:

# Only rule to execute the Unit Test script/exe of this SE component.
run_$(TEST_MUL): $(TEST_MUL).out
	-./$(TEST_MUL).out

# Create the executable file
$(TEST_MUL).out: $(DEP_MUL) gmock_main.a
	@echo "--> Compiling $(TEST_MUL).o"
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $(TESTCASE_DIR)/$(COMP_MUL/$(TEST_MUL).cc
	@echo "--> Creating $(TEST_MUL).o"
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -lpthread $^ -o $@