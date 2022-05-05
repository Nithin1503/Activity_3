#include"ask.h"
#include<stdio.h>
#include<string.h>
int name(char str[])
{
  char *p=str;
  int k = strlen(str), sum=0;
  int arr[k];
  for(int i=0;i<=k;i++)
  {
     arr[i]=(int)*(p+i);
     sum+=arr[i];
   }
   return sum;
}