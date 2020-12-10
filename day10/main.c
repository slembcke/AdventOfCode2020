#include <stdio.h>

// int jolts[] = {1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31, 32, 33, 34, 35, 38, 39, 42, 45, 46, 47, 48, 49};
int jolts[] = {1, 2, 5, 6, 7, 8, 9, 12, 13, 14, 15, 18, 21, 22, 23, 26, 27, 28, 29, 30, 33, 34, 35, 36, 39, 42, 43, 44, 45, 48, 51, 54, 55, 56, 57, 60, 61, 62, 63, 64, 67, 68, 69, 72, 75, 76, 79, 80, 81, 82, 83, 86, 89, 90, 91, 92, 95, 98, 99, 100, 101, 104, 107, 108, 109, 110, 113, 114, 115, 116, 117, 120, 123, 126, 129, 130, 131, 132, 133, 136, 137, 138, 139, 140, 143, 144, 145, 146, 147, 150, 151, 152, 153, 154, 157, 158, 161, 162, 163, 164, 165};
int jolt_count = sizeof(jolts)/sizeof(*jolts);

unsigned long count = 0;

static void chain_rec(int idx0, int jolt){
	if(idx0 == jolt_count){
		count = count + 1;
		if((count % (1 << 20)) == 0) printf("tally: %d\n", count >> 20);
		return;
	}
	
	for(int i = idx0; i < jolt_count; i++){
		if(jolts[i] > jolt + 3) break;
		chain_rec(i + 1, jolts[i]);
	}
}

int main(void){
	chain_rec(0, 0);
	printf("%d\n", count);
}
