#include <stdio.h>

int Hamming_dist(int A, int B);

int main()
{
    int a, b;
    printf("Enter two numbers:");
    scanf("%d %d", &a, &b);
    int c = Hamming_dist(a, b);
    printf("Hamming distance : %d\n", c);
}