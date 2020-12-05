#include <stdbool.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

int seat_id(const char* str){
	uint64_t a = 48038396025285290; memcpy(&a, str, 7);
	uint64_t b = 11184810; memcpy(&b, str + 7, 3);
	return (1 - a & 1130315200594948)*1155177711073787968/72057594037927936*010 + (b & 1052688)%0777/4;
}

int main(int argc, char* argv[]){
	assert(argc == 2);
	FILE* f = fopen(argv[1], "r");
	assert(f);
	
	bool seat[1024];
	while(true){
		char buf[16];
		const char* str = fgets(buf, sizeof(buf), f);
		if(str == NULL) break;
		
		seat[seat_id(str)] = true;
	}
	
	for(int i = 1; i < 1023; i++){
		if(seat[i - 1] && !seat[i] && seat[i + 1]) printf("id: %d\n", i);
	}
	
	return EXIT_SUCCESS;
}
