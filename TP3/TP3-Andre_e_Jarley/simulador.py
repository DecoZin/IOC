"""Module to simulate a Cache Memory."""
import math

class Cache():
    """Class to simulate a Cache"""
    def __init__(self, cache_size, block_size, set_size) -> None:
        self.cache_size = cache_size
        self.block_size = block_size
        self.set_size = set_size

        self.hit_count = 0
        self.miss_count = 0

        # Calculating the number of sets
        self.num_sets = (cache_size // block_size) // set_size

        # Bitmask for getting index
        self.index_mask = (self.num_sets - 1)


        # Initialize cache as a list of sets, each set is a list of blocks
        # Each block is represented as a dictionary with 'valid', 'index', and 'address'
        self.cache = [
            [{'valid': False, 'index': i, "address": None} for i in range(set_size)]
            for i in range(self.num_sets)
        ]

    def access(self, address):
        """Access the cache saving the address accessed and making the valid true"""
        index = self.index_mask & address
        address = address >> int(math.log(self.block_size, 2))



def main():
    """Main Function."""
    cache_size = int(input()) # Cache size in bytes
    block_size = int(input()) # Block size in bytes
    set_size = int(input())   # Set size in blocks
    txt_file = input()        # File with addresses

    if not txt_file.endswith('.txt'):
        txt_file = txt_file + '.txt'

    cache = Cache(cache_size, block_size, set_size)

    address = 0x12345678
    num_sets = 4
    index = address & (num_sets - 1) 

    print(cache_size)
    print(block_size)
    print(set_size)
    print(txt_file)


if __name__ == '__main__':
    main()

# End-of-file (EOF)
