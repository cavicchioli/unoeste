/* rand example: guess the number */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main ()
{
  int iSecret, iGuess;

  /* initialize random seed: */
  srand ( time(NULL) );

  /* generate secret number: */
  iSecret = rand() % 10 + 1;

  do {
    printf ("Guess the number (1 to 10): ");
    scanf ("%d",&iGuess);
    if (iSecret<iGuess) puts ("The secret number is lower");
    else if (iSecret>iGuess) puts ("The secret number is higher");
  } while (iSecret!=iGuess);

  puts ("Congratulations!");
  return 0;
}
