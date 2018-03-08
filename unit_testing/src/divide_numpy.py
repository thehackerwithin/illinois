import numpy

def divide(numerator, denomator):
    """ function to perform division of two numbers. This should not perform
        integer division
        
        Raises:
        ZeroDivisionError: raised if denominator is zero
    """
    return numpy.float64(numerator)/numpy.float64(denomator)