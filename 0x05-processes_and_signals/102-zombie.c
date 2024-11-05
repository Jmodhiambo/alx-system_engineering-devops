#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

/**
 * infinite_while - function that runs an infinite loop
 *
 * Return: 0 on success
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
 * main - entry point of the program
 *
 * Return: 0 on success
 */
int main(void)
{
	pid_t pid;
	int i;

	for (i = 0; i < 5; i++)
	{
		pid = fork();
		if (pid > 0)  /* Parent process */
		{
			printf("Zombie process created, PID: %d\n", pid);
		}
		else if (pid == 0)  /* Child process */
		{
			return (0);  /* Exit child process */
		}
		else  /* Fork failed */
		{
			perror("Fork failed");
		}
	}
	infinite_while();  /* Keep the parent process running */
	return (0);
}
