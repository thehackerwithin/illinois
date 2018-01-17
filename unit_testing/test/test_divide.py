from divide import divide

import pytest

def test_divide_ints():
    assert divide(4,2) == 2

def test_divide_floats():
    assert divide(5.0, 2.0) == 2.5

def test_zero_division():
    with pytest.raises(ZeroDivisionError) as e_info:
        divide(4.0,0.0)