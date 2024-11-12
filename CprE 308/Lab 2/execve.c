#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>

int main() {
	execl("/bin/ls", "ls", NULL);
	printf("What happened?\n");
}
