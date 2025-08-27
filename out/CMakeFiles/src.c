
void foo(void)  __arm_streaming_compatible {
  asm(".arch armv9-a+sme");
  asm("smstart");
}

