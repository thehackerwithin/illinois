from divide import divide

import numpy

def test_integer_division():
    assert divide(1,2) != 0, "performed integer division"

def test_lists():
    left_list  = [1,2,3,4]
    right_list = [2,2,3,4]
    assert left_list == right_list

def test_dictionaries():
    left_dic  = {'item1': 1, 'item2':2, 'item3':3}
    right_dic = {'item1': 2, 'item2':2, 'item4':3}
    assert left_dic == right_dic

def test_numpy_arrays():
    left_array  = numpy.array([1,2,3,4])
    right_array = numpy.array([2,2,3,4])
    assert numpy.array_equal(left_array, right_array) == True