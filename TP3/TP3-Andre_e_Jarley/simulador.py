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
                'address': None,
                'access_time': 0 } for i in range(set_size)]
            for j in range(self.num_sets)
        ]

    def access(self, address):
        """Access the cache saving the address accessed and making the valid true"""

        set_index = self.index_mask & address
        address = address >> int(math.log(self.block_size, 2))
        older_block = 0
        older_access = 0
        for i in range(self.set_size):
            if self.cache[set_index][i]['access_time'] > older_access:
                older_access = self.cache[set_index][i]['access_time']
                older_block = i
            self.cache[set_index][i]['access_time'] += 1
        if  self.cache[set_index][older_block]['address'] == address:
            self.hit_count += 1
        else:
            self.miss_count += 1
        self.cache[set_index][older_block]['address'] = address
        self.cache[set_index][older_block]['access_time'] = 0
        self.cache[set_index][older_block]['valid'] = True
        self.print_cache()

    def print_cache(self):
        """Save in the output.txt file all the cache blocks in the following format:
        ================
        IDX V ** ADDR **
        000 x 0x000XXXXX
        001 x 0x000XXXXX
        002 x 0x000XXXXX
               ...
        xxx x 0x000XXXXX        
        """
        with open('TP3/TP3-Andre_e_Jarley/output.txt', 'a', encoding="utf-8") as f:
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
                        f.write(f"{formatted_idx} {formatted_valid} {formatted_address.upper()}")

    def end(self):
        """Save number of hits and misses to the end of the output file."""

        with open('TP3/TP3-Andre_e_Jarley/output.txt', 'a', encoding="utf-8") as f:
            f.write("\n")
            f.write(f"#hits: {self.hit_count}\n")
            f.write(f"#miss: {self.miss_count}")


def main():
    """Main Function."""

    # Create or empty file output.txt
    with open('TP3/TP3-Andre_e_Jarley/output.txt', 'w', encoding="utf-8") as _:
        pass

    cache_size = 4096 #int(input()) # Cache size in bytes
    block_size = 1024 #int(input()) # Block size in bytes
    set_size = 4 #int(input())   # Set size in blocks
    txt_file = 'TP3/TP3-Andre_e_Jarley/test'#input()        # File with addresses

    if not txt_file.endswith('.txt'):
        txt_file = txt_file + '.txt'

    cache = Cache(cache_size, block_size, set_size)

    with open(txt_file, 'r', encoding="utf-8") as f:
        for line in f:
            address = int(line.strip(), 16)
            cache.access(address)

    cache.end()



if __name__ == '__main__':
    main()

# End-of-file (EOF)
