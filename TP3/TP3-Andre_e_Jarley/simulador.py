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
        self.index_mask = self.num_sets - 1

        # Initialize cache as a list of sets, each set is a list of blocks
        # Each block is represented as a dictionary with 'valid', 'index', and 'address'
        self.cache = [
            [{
                'valid': False,
                'block_index': i + j*set_size,
                'set_index': j,
                'address': None } for i in range(set_size)]
            for j in range(self.num_sets)
        ]

    def access(self, address):
        """Access the cache saving the address accessed and making the valid true"""

        index = self.index_mask & address
        address = address >> int(math.log(self.block_size, 2))

    def print(self):
        """Save in the output.txt file all the cache blocks in the following format:
        ================
        IDX V ** ADDR **
        000 x 0x000XXXXX
        001 x 0x000XXXXX
        002 x 0x000XXXXX
               ...
        xxx x 0x000XXXXX        
        """

        with open('output.txt', 'a', encoding="utf-8") as f:
            f.write("================\n")
            f.write("IDX V ** ADDR **\n")
            for j in range(self.num_sets):
                for i in range(self.set_size):
                    formatted_idx = f"{self.cache[j][i]["block_index"]:03}"
                    formatted_valid = f"{int(self.cache[j][i]["valid"])}"
                    if self.cache[j][i]["address"] is None:
                        f.write(f"{formatted_idx} {formatted_valid} \n")
                    else:
                        formatted_address = f"0x{self.cache[j][i]["address"]:0{8}x}\n"
                        f.write(f"{formatted_idx} {formatted_valid} {formatted_address}")

def main():
    """Main Function."""

    # Create or empty file output.txt
    with open('output.txt', 'w', encoding="utf-8") as _:
        pass

    cache_size = 4096 #int(input()) # Cache size in bytes
    block_size = 1024 #int(input()) # Block size in bytes
    set_size = 4 #int(input())   # Set size in blocks
    txt_file = 'test'#input()        # File with addresses

    if not txt_file.endswith('.txt'):
        txt_file = txt_file + '.txt'

    cache = Cache(cache_size, block_size, set_size)
    cache.print()


if __name__ == '__main__':
    main()

# End-of-file (EOF)
