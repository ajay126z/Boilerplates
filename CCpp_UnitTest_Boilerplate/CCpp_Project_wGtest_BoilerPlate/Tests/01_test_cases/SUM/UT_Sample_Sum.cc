#include "gtest.h"
#include "gmock.h"
#include <stdio.h>
#include <stdlib.h>

// Include File to Test
#include "Sample_Sum.c"

/**************************************************************/
// Mocking Framework
/**************************************************************/
using namespace ::testing;
using ::testing::Return;

// Create a Module Mock Class where all other interfaces are created in terms of METHODS.
class SAMPLE_SUM_MOCK{
    public:
        virtual ~SAMPLE_SUM_MOCK() {}
        //MOCK_METHOD0(AddTwoVariable, int(void));

};

// Create a TestFixture
class TestFixture : public ::testing::Test
{
    public:
        // Constructor
        TestFixture()
        {
            _sampleSumMock.reset(new ::testing::NiceMock<SAMPLE_SUM_MOCK>);
        }

        // Destructor
        ~TestFixture()
        {
            _sampleSumMock.reset();
        }

        virtual void SetUp() {}
        virtual void TearDown() {}

        //Pointer for Accessing Mocked Library
        static std::unique_ptr<SAMPLE_SUM_MOCK> _sampleSumMock;
};

std::unique_ptr<SAMPLE_SUM_MOCK> TestFixture::_sampleSumMock;

//int AddTwoVariable(void)
//{
//   return TestFixture::_sampleSumMock->AddTwoVariable();
//}

/**************************************************************/
// Tests
/**************************************************************/

class sum2num_ : public TestFixture
{
    public:
        sum2num_(){}
};

TEST_F(sum2num_, sum1020)
{
    // Arrange
    int result = 0;

    // Act
    result = sum2num(10,20);

    // Assert   
    ASSERT_EQ(result,30);
}