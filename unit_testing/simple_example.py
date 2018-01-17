def divide(numerator, denominator):
    """ function to perform division of two numbers. This should not perform
        integer division
        
        Raises:
            ZeroDivisionError: raised if denominator is zero
    """
    return numerator/denominator

def test_divide_ints():
    """test division of two integers 4 and 2"""
    assert divide(4,2) == 2