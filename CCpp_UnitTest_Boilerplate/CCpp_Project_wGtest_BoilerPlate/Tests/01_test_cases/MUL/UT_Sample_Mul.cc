#include "gtest.h"
#include "gmock.h"
#include <stdio.h>
#include <stdlib.h>

// Include File to Test
#include "Sample_Mul.c"

/**************************************************************/
// Mocking Framework
/**************************************************************/
using namespace ::testing;
using ::testing::Return;

// Create a Module Mock Class where all other interfaces are created in terms of METHODS.
class SAMPLE_MUL_MOCK{
    public:
        virtual ~SAMPLE_MUL_MOCK() {}
        //MOCK_METHOD0(AddTwoVariable, int(void));

};

// Create a TestFixture
class TestFixture : public ::testing::Test
{
    public:
        // Constructor
        TestFixture()
        {
            _sampleMulMock.reset(new ::testing::NiceMock<SAMPLE_MUL_MOCK>);
        }

        // Destructor
        ~TestFixture()
        {
            _sampleMulMock.reset();
        }

        virtual void SetUp() {}
        virtual void TearDown() {}

        //Pointer for Accessing Mocked Library
        static std::unique_ptr<SAMPLE_MUL_MOCK> _sampleMulMock;
};

std::unique_ptr<SAMPLE_MUL_MOCK> TestFixture::_sampleMulMock;

//int AddTwoVariable(void)
//{
//   return TestFixture::_sampleMulMock->AddTwoVariable();
//}

/**************************************************************/
// Tests
/**************************************************************/

class mul2num_ : public TestFixture
{
    public:
        mul2num_(){}
};

TEST_F(mul2num_, mul1020)
{
    // Arrange
    int result = 0;

    // Act
    result = mul2num(10,20);

    // Assert   
    ASSERT_EQ(result,200);
}