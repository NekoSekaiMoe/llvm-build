volatile int x;
__attribute__((constructor)) void f(void) {x = 0;}
int main(void) { return 0; }

