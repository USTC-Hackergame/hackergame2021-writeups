#include "stdio.h"
#include "stdlib.h"
#define Rand() random()
int array[100000] = {0};
int RND(int x)
{
	static int cnt = 0;
	cnt++;
	int ran = (Rand() % (long)(x));
	/*fprintf(stderr, "RNG: %d, %d, %d\r\n", cnt, x, ran);*/
	return ran;
}
int main()
{
	srandom(0);
	int cnt = 0;
	/*int rng_start_cnt = 3922;*/
	int rng_start_cnt = 3502;
	int r;
	int i;
	for (cnt = 0; cnt < rng_start_cnt; cnt++)
		r = random();
	// now at critical position: fountain here, wall nearby
	for (cnt = 0; cnt < 10000000; cnt++) {
		r = random();
		if ((r % 30 + 1) == 23)
			printf("%d\n", cnt);
	}
	/*for (cnt = 0; cnt < 100000; cnt++)*/
		/*array[cnt] = random(); // rnd() in nethack*/
	/*// pick out useful pairs from pool*/
	/*// fate = rnd(30) --> 23 --> water demon*/
	/*// rnd(100) > 80 + 1 --> wish*/
	/*for (cnt = 0; cnt < 99990; cnt++) {*/
		/*if ((array[cnt] % 30 + 1) == 23 && \*/
			/*(array[cnt+14] % 100 + 1) > 81) {*/

			/*printf("Need to bump wall %d times\n", cnt);*/
			/*break;*/
		/*}*/
	/*}*/
	/*for (i = 0; i < cnt; i++)*/
		/*printf("j");*/
	
	/*int i;*/
	/*for (i = 0; i < 20; i++)*/
		/*printf("%d ", random());*/
	return 0;
}
