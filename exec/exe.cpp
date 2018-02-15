#include <stdio.h>

#include "ProjA/a.h"
#include "ProjB/b.h"

int doA();
int doB();

int main(void) {
    printf("%d\n", doA());
    printf("%d\n", doB());
    return 0;
}