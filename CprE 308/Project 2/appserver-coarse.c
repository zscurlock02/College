#include "Bank.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <sys/time.h>

//Stores mutex lock associated with each acocunt
typedef struct account {
	pthread_mutex_t lock;
	int value;
}account;

//Stores command within linked list
typedef struct storeCommand {
	char* command;
	int id;
	struct timeval timestamp;
	struct storeCommand* next;
	
}storeCommand;

//Stores data about linked list
typedef struct LinkedList {
	pthread_mutex_t lock;
	storeCommand* head;
	storeCommand* tail;
	int size;
}LinkedList;

//Function Prototypes
int accountLock(account* toLock);
int accountUnlock(account* toUnlock);
storeCommand nextCommand();
int newCommandAdder(char* commandEntered, int id);
int argumentParser(int argc, char** argv);
int accountSetup();
int commandBufferSetup();
int clientLoop();
void incorrectFormat();
void* requestHandler();

int run = 1; //marks if thread should be running or not
account* accounts;
LinkedList* commandBuffer;
int numWorkers;
int numAccounts;
pthread_mutex_t tokenLock;
pthread_mutex_t bankLock;
FILE* file;

int main(int argc, char** argv) {
	commandBuffer = malloc(sizeof(LinkedList));

	if(argumentParser(argc, argv)) {
		return -1;
	}

	accounts = malloc(numAccounts* sizeof(account));

	if(commandBufferSetup()) {
		return -1;
	}

    if(accountSetup()) {
		return -1;
	}

	if(clientLoop()) {
		return -1;
	}

	free(commandBuffer);
	free(accounts);
	free_accounts();
	fclose(file);

	return 0;
}

//Parses command line arguments
int argumentParser(int argc, char** argv) {
    //checks for correct number of arguments
	if(argc != 4) {
		fprintf(stderr, "error (appserver): incorrect number of command line arguments\n");
		fprintf(stderr, "appserver expected format: ");
		fprintf(stderr, "appserver numWorkers numAccounts fileName");
		fprintf(stderr, "\nappserver: exiting program\n");
		return -1;
	}
    //stores arguments
	if(!sscanf(argv[1], "%d", &numWorkers)) {
		incorrectFormat();
		return -1;
	}
    
	if(!sscanf(argv[2], "%d", &numAccounts)) {
		incorrectFormat();
		return -1;
	}

	file = fopen(argv[3], "w");

	if(!file) {
		fprintf(stderr, "error: failed to open file\n");
		fprintf(stderr, "appserver: exiting program\n");
		return -1;
	}

	return 0;
}

//Sets up accounts
int accountSetup() {
	int i;
	initialize_accounts(numAccounts);

	for(i = 0; i < numAccounts; i++) {
		pthread_mutex_init(&(accounts[i].lock), NULL);
		accounts[i].value = 0;
	}

	return 0;
}

//Initializes command buffer
int commandBufferSetup() {
	pthread_mutex_init(&(commandBuffer -> lock), NULL);
	commandBuffer -> head = NULL;
	commandBuffer -> tail = NULL;
	commandBuffer -> size = 0;
	return 0;
}

//Executes threads until exit
int clientLoop() {
	pthread_t workers[numWorkers];
	int i;
	size_t n = 100;
	size_t readSize = 0;
	char* command = malloc(sizeof(char) * 200);
	int id = 1;

	for(i = 0; i < numWorkers; i++) {
		pthread_create(&workers[i], NULL, requestHandler, NULL);
	}

	pthread_mutex_init(&tokenLock, NULL);
	pthread_mutex_init(&bankLock, NULL);

	while(1) {
		readSize = getline(&command, &n, stdin);
		command[readSize - 1] = '\0';

		if(strcmp(command, "END") == 0) {
			run = 0;
			break;
		}

		printf("ID %d\n", id);
		newCommandAdder(command, id);
		id++;
	}

	while(commandBuffer -> size > 0) {
		usleep(1);
	}
	for(i = 0; i < numWorkers; i++) {
		pthread_join(workers[i], NULL);
	}
	free(command);
	return 0;
}

//prints incorrect argument format to stderr
void incorrectFormat() {
	fprintf(stderr, "error: incorrect argument format\n");
	fprintf(stderr, "expected format: ");
	fprintf(stderr, "appserver numWorkers numAccounts fileName");
	fprintf(stderr, "\nappserver: exiting program\n");
}

void* requestHandler() {
	storeCommand currentCommand; // current command
	char** commandTokens = malloc(sizeof(char*) * 21);
	char* currentToken;
	int numTokens = 0;
	int checkAccount;
	int amount;
	int i, j;
	int insufficientFunds = 0;
	struct timeval timestamp2;

	while(run || commandBuffer -> size > 0) {
        //sleeps until commands are present
		while(commandBuffer -> size == 0 && run) {
			usleep(1);
		}

		currentCommand = nextCommand();

		if(!currentCommand.command) {
			continue;
		}

		pthread_mutex_lock(&tokenLock);
		currentToken = strtok(currentCommand.command, " ");
		while(currentToken) {
			commandTokens[numTokens] = malloc(sizeof(char) * 21);
			strncpy(commandTokens[numTokens], currentToken, 21);
			numTokens++;
			currentToken = strtok(NULL, " ");
		}
		pthread_mutex_unlock(&tokenLock);

		if(strcmp(commandTokens[0], "CHECK") == 0 && numTokens == 2) {
			pthread_mutex_lock(&tokenLock);
			checkAccount = atoi(commandTokens[1]);
			pthread_mutex_unlock(&tokenLock);
			pthread_mutex_lock(&bankLock);
			amount = read_account(checkAccount);
			pthread_mutex_unlock(&bankLock);
			gettimeofday(&timestamp2, NULL);
			flockfile(file);
			fprintf(file, "%d BAL %d TIME %d.%06d %d.%06d\n", currentCommand.id, amount, currentCommand.timestamp.tv_sec, currentCommand.timestamp.tv_usec, timestamp2.tv_sec, timestamp2.tv_usec);
			funlockfile(file);
		}

		else if(strcmp(commandTokens[0], "TRANS") == 0 && numTokens % 2 && numTokens > 1) {
			int numTransactions = (numTokens - 1) / 2;
			int transactionAccounts[numTransactions];
			int transactionAmounts[numTransactions];
			int transactionBalance[numTransactions];
			int temp;

			pthread_mutex_lock(&bankLock);

			for(i = 0; i < numTransactions; i++) {
				pthread_mutex_lock(&tokenLock);
				transactionAccounts[i] = atoi(commandTokens[i * 2 + 1]);
				transactionAmounts[i] = atoi(commandTokens[i * 2 + 2]);
				pthread_mutex_unlock(&tokenLock);
			}

			for(i = 0; i < numTransactions; i++) {
				transactionBalance[i] = read_account(transactionAccounts[i]);
				if(transactionBalance[i] + transactionAmounts[i] < 0) {
					gettimeofday(&timestamp2, NULL);
					flockfile(file);
					fprintf(file, "%d ISF %d TIME " "%d.06%d %d.06%d\n", currentCommand.id, transactionAccounts[i], currentCommand.timestamp.tv_sec, currentCommand.timestamp.tv_usec, timestamp2.tv_sec, timestamp2.tv_usec);
					funlockfile(file);
					insufficientFunds = 1;
					break;
				}
			}
			if(!insufficientFunds) {
				for(i = 0; i < numTransactions; i++) {
					write_account(transactionAccounts[i], (transactionBalance[i] + transactionAmounts[i]));
				}
				gettimeofday(&timestamp2, NULL);
				flockfile(file);
				fprintf(file, "%d OK TIME %d.%06d %d.%06d\n", currentCommand.id, currentCommand.timestamp.tv_sec, currentCommand.timestamp.tv_usec, timestamp2.tv_sec, timestamp2.tv_usec);
				funlockfile(file);
			}
			pthread_mutex_unlock(&bankLock);
		}
		else {
			fprintf(stderr, "%d INVALID REQUEST FORMAT\n", currentCommand.id);
		}
		free(currentCommand.command);
		for(i = 0; i < numTokens; i++) {
			free(commandTokens[i]);
		}
		numTokens = 0;
		insufficientFunds = 0;
	}
	free(commandTokens);
	return;
}

//Locks account mutex
int accountLock(account* toLock) {
	if(pthread_mutex_trylock(&(toLock->lock))) {
		return -1;
	}
	return 0;
}

//Unlocks account mutex
int accountUnlock(account* toUnlock) {
	pthread_mutex_unlock(&(toUnlock->lock));
	return 0;
}

//Retrieves next command in linked list
storeCommand nextCommand() {
	storeCommand* tempHead;
	storeCommand returnValue;

	pthread_mutex_lock(&(commandBuffer->lock));

	if(commandBuffer->size > 0) {
		returnValue.id = commandBuffer->head->id;
		returnValue.command = malloc(sizeof(char) * 200);
		returnValue.timestamp = commandBuffer->head->timestamp;
		strncpy(returnValue.command, commandBuffer->head->command, 200);
		returnValue.next = NULL;

		tempHead = commandBuffer->head;
		commandBuffer->head = commandBuffer->head->next;
		free(tempHead->command);
		free(tempHead);

		if(!commandBuffer->head) {
			commandBuffer->tail = NULL;
		}

		commandBuffer->size = commandBuffer->size - 1;
	}
	else {

		pthread_mutex_unlock(&(commandBuffer->lock));

		returnValue.command = NULL;
		return returnValue;
	}
	pthread_mutex_unlock(&(commandBuffer->lock));
	return returnValue;
}

//Adds command to linked list
int newCommandAdder(char* commandEntered, int id) {
	storeCommand* new_tail = malloc(sizeof(storeCommand));

	//builds command
	new_tail->command = malloc(sizeof(char) * 200);
	strncpy(new_tail->command, commandEntered, 200);
	new_tail->id = id;
	gettimeofday(&(new_tail->timestamp), NULL);
	new_tail->next = NULL;

	pthread_mutex_lock(&(commandBuffer->lock));

	if(commandBuffer->size > 0) {
		commandBuffer->tail->next = new_tail;

		commandBuffer->tail = new_tail;
		commandBuffer->size = commandBuffer->size + 1;
	}
	else {
		commandBuffer->head = new_tail;
		commandBuffer->tail = new_tail;
		commandBuffer->size = 1;
	}

	pthread_mutex_unlock(&(commandBuffer->lock));
	return 0;
}
