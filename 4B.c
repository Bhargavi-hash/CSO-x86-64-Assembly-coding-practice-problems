#include <stdio.h>
void search(char* A, short int* B);
int main(){
    char sen[35];
    short int frq[26]={0};
    printf("Enter the string:");
    for(int i = 0; i < 32; i++){
        scanf("%c",&sen[i]);
    }
    
    sen[32]='\0';
    search(sen, frq);
    for(int i = 0; i < 26; i++)
    {
        printf("%c\t--\t%hd\n",65+i,frq[i]);
    }
}

