appserver: appserver.o Bank.o
	gcc -o appserver -pthread appserver.o Bank.o
appserver.o: appserver.c
	gcc -c -pthread appserver.c
Bank.o: Bank.c
	gcc -c Bank.c
clean:
	rm appserver appserver.o Bank.o
