"""module that computes the power efficiency of a cycle"""

input_power = 0
output_power = 0

def compute_efficiency():
    """Computes the power efficiency of a thermal cycle
    Raises:
        ValueError: if power is negative
    """
    if output_power < 0:
        raise ValueError
    
    return output_power/input_power