#include <stdint.h>
#include <inttypes.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

int64_t check(FILE* f, int dx, int dy){
	fseek(f, 0, SEEK_SET);
	
	int tree_count = 0, x = 0, y = 0;
	while(1){
		char row[1024];
		int result = fscanf(f, "%s\n", row);
		if(result != 1) break;
		
		if(y++ % dy != 0) continue;
		
		size_t row_len = strlen(row);
		if(row[x % row_len] == '#') tree_count++;
		x += dx;
	}
	
	printf("(%d, %d): %d\n", dx, dy, tree_count);
	return tree_count;
}

int main(int argc, char* argv[]){
	assert(argc == 2);
	FILE* f = fopen(argv[1], "r");
	assert(f);
	
	int64_t product = (1
		*check(f, 1, 1)
		*check(f, 3, 1)
		*check(f, 5, 1)
		*check(f, 7, 1)
		*check(f, 1, 2)
	);
	printf("product: %"PRId64"\n", product);
	return EXIT_SUCCESS;
}
