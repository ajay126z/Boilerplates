import unittest 

# import ProjPackage as a Package
from ProjPackage.circle import Circle
from math import pi

class TestCircleArea(unittest.TestCase):
    def test_area(self):
        # Test Areas with radius >= 0
        self.assertAlmostEqual(Circle.CalculateArea(1.0), pi)
        self.assertAlmostEqual(Circle.CalculateArea(0), 0)
        self.assertAlmostEqual(Circle.CalculateArea(2.1), pi * 2.1**2)
    
    def test_values(self):
        # Make sure value errors are raised when necessary
        self.assertRaises(ValueError, Circle.CalculateArea, -2)
    
    def test_types(self):
        # Make sure value errors are raised when necessary
        self.assertRaises(TypeError, Circle.CalculateArea, 3+5j)
        self.assertRaises(TypeError, Circle.CalculateArea,True)
        self.assertRaises(TypeError, Circle.CalculateArea,"radius")


