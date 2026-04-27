from math import pi

class Circle:
    def __init__(self):
        None
    
    def CalculateArea(radius):
        if type(radius) not in [int, float]:
            raise TypeError("Circle radius must be of int or float type!")
        if radius < 0:
            raise ValueError("Circle cannot have negative radius!")
        return pi * (radius**2)
        