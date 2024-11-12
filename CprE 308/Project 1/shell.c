#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv[]){
    
    char* prompt = "308sh> ";

    char input[200];
    char directory[200];
    char currentWorkingDirectory[1024];
    char cdArg[200];

    int i,j;
    int status;
    int argCount;
    int child1, child2;
    int bgProcess = 0;


    //Checks if argument is correct size
    if(argc != 3 && argc != 1){
        printf("Invalid command. Now exiting.\n");
        return 0;
    }

    //Checks for prompt
    if(argc == 3){
        //makes sure the first argument is not "-p"
        if(strcmp(argv[1], "-p") == 0){
            //assign prompt to prompt variable
            prompt = argv[2];
        }
        else{
            printf("Invalid command. Now exiting.\n");
            return 0;
        }
    }

    //infinite loop for user input
    while(1){
        printf(prompt);

        //Retrieves user input
        fgets(input, 200, stdin);

        input[strcspn(input, "\n")] = '\0';

        //exit
        if(strcmp(input, "exit") == 0){
            return 0;
        }

        //pid
        else if(strcmp(input, "pid") == 0){
            printf("Shell Process ID: %d\n", getpid());
        }

        //ppid
        else if(strcmp(input, "ppid") == 0){
            printf("Shell Parent Process ID: %d\n", getppid());
        }

        //cd
        else if(strcmp(input, "cd") == 0 || strncmp("cd ", input, 3) == 0){
            if(strlen(input) == 2){
                chdir(getenv("HOME"));
            }
            else{
                for(i = 3; i < strlen(input); i++){
                    cdArg[i - 3] = input[i];
                    cdArg[i - 2] = '\0';
                }
                if(chdir(cdArg) == -1){
                    printf("Can't find directory\n");
                }
            }
            
        }

        //pwd
        else if(strcmp(input, "pwd") == 0){
            if(getcwd(currentWorkingDirectory, 1024) == -1){
                printf("ERROR\n");
            }
            else{
                printf("%s\n", currentWorkingDirectory);
            }
        }
        
        //Non-Builtin Commands
        else{
            //count arguments
            argCount = 1;
            for(i =0; i < strlen(input); i++){
                if(input[i] == ' '){
                    argCount++;
                }
            }

            //check if last argument is &
            if(input[strlen(input) - 1] == '&'){
                argCount--;
                bgProcess = 1;
            }

            //fills args[] with each argument
            char temp[argCount][200];
            char* args[argCount + 1];
            argCount = 0;
            j = 0;

            for(i = 0; i < strlen(input) + 1; i++){
                if(input[i] == ' ' || input[i] == '\0'){
                    temp[argCount][j] = '\0';
                    args[argCount] = temp[argCount];
                    argCount++;
                    j = 0;
                }
                else if(input[i] == '&' && i == strlen(input) - 1){
                    i = strlen(input) + 1;
                }
                else{
                    temp[argCount][j] = input[i];
                    j++;
                }
            }

            args[argCount] = (char*) NULL;

            //If a background process creates a child process that will spawn another child process, child1 will wait for child2 to complete.
            if(bgProcess == 1){

                bgProcess = 0;
                child2 = fork();

                if(child2 == 0){
                    child1 = fork();
                    if(child1 == 0){
                        printf("[%d] %s\n", getpid(), args[0]);  //prints PID and command name
                        execvp(args[0], args);
                        perror("\0");
                        return 0;
                    }
                    else{
                        status = -1;
                        waitpid(-1, &status, 0);
                        printf("[%d] %s Exit %d\n", child1, args[0], WEXITSTATUS(status));
                        printf(prompt);
                        return 0;
                    }
                }
                else{
                    usleep(1000);
                }
            }

            //Creates a child process that runs a command and waits to complete before it accepts more input 
            else{
                child1 = fork();

                if(child1 == 0){
                    printf("[%d] %s\n", getpid(), args[0]);  //print process ID and command name
                    execvp(args[0], args);
                    perror("\0");
                    return 0;
                }
                else{
                    usleep(1000);
                    status = -1;
                    waitpid(child1, &status, 0);
                    printf("[%d] %s Exit %d\n", child1, args[0], WEXITSTATUS(status)); //prints child process ID name and return status
                } 
            }
        }
    }
    return 0;
}