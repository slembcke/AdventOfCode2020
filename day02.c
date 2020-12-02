#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

int main(int argc, char* argv[]){
	assert(argc == 2);
	FILE* f = fopen(argv[1], "r");
	assert(f);
	
	unsigned valid_passwords = 0;
	while(true){
		int min, max;
		unsigned char chr, str[1024]; // Data is known in advance, so... meh.
		int result = fscanf(f, "%d-%d %c: %s\n", &min, &max, &chr, str);
		if(result != 4) break;
		
		
		// Part 1:
		// unsigned count = 0;
		// for(unsigned i = 0; str[i]; i++) count += (chr == str[i]);
		// valid_passwords += (min <=count && count <= max);
		
		// Part 2:
		valid_passwords += ((chr == str[min - 1]) ^ (chr == str[max - 1]));
	}
	
	printf("valid_passwords passwords: %d", valid_passwords);
	return EXIT_SUCCESS;
}