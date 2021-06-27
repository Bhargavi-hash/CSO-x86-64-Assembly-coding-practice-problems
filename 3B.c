#include <stdio.h>
int Rotate(short mat[8][8]);
int main()
{
    short mat[8][8];
    printf("Enter the matrix:\n");
    for (int i = 0; i < 8; i++)
    {
        for (int j = 0; j < 8; j++)
        {
            scanf("%hd", &mat[i][j]);
        }
    }
    Rotate(mat);
    printf("90 degrees clockwise rotated matrix:\n");
    for (int i = 0; i < 8; i++)
    {
        for (int j = 0; j < 8; j++)
        {
            printf("%hd ", mat[i][j]);
        }
        printf("\n");
    }
}