#include <stdio.h>
#include <unistd.h>

double compute_pi(size_t dt)
{
   	#if 0
			printf("size_t is %lu byte(s)\n", sizeof(size_t));
			printf("max size_t is %lx\n", SIZE_MAX);
	 	#endif
	 	double pi = 0.0;
    double delta = 1.0 / dt;
    for (size_t i = 0; i < dt; i++) {
        double x = (double) i / dt;
        pi += delta / (1.0 + x * x);
    }
    return pi * 4.0;
}


int main(void)
{
		//printf("pid: %d\n", getpid());

		sleep(20);

		compute_pi(1024*1024*1024);

		//printf(" complete !!");
		return 0;
}
