import power_efficiency as pe

def setup_module(module):
    print ""
    print "module setup"
    pe.input_power = 100. # kJ
    pe.output_power = 30. # kJ

def teardown_module(module):
    print ""
    print "module teardown"
    pe.input_power = 0. # kJ
    pe.output_power = 0. # kJ

def test_input_power():
    print "test input power"
    assert pe.input_power == 100.

def test_compute_efficiency():
    print "\ntest efficiency"
    assert pe.compute_efficiency() == 0.3 # it's not very efficient