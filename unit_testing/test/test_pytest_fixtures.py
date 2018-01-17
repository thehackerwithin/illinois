import power_efficiency as pe
import pytest

@pytest.fixture
def set_power():
    print "\nset the power"
    pe.input_power = 100. # kJ
    pe.output_power = 30. # kJ

@pytest.fixture
def set_negative_power():
    print "\nset negative output power"
    pe.input_power = 100. # kJ
    pe.output_power = -30. # kJ

def test_input_power(set_power):
    print "test input power"
    assert pe.input_power == 100.

def test_compute_efficiency(set_power):
    print "test efficiency with setup"
    assert pe.compute_efficiency() == 0.3 # it's not very efficient

def test_negative_power(set_negative_power):
    print "test efficiency with negative power"
    with pytest.raises(ValueError) as e_info:
        pe.compute_efficiency()

