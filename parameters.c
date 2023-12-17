#include <stdio.h>

extern void display_parameters(int argc, char* argv[]);

int main(int argc, char* argv[])
{
    display_parameters(argc, argv);
}
