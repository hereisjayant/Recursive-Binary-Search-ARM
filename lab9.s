.globl binary_search
binary_search:
//saving the registers
  push   {r4-r8, lr}
  sub r6, r3,r2	  //r6 = endIndex - startIndex
  mov r6, r6, LSR#1 //r6 = r6/2
  add r6, r6, r2    //middleIndex = startIndex + (endIndex - startIndex)/2;
  add r4, r4, #1    //NumCalls++;

  CMP r2, r3        //Compare (startIndex, endIndex)
  ble first_else_if   //branch
  mov r0, #1
  sub r0, r0, r0, LSL#1 //subtracting 1 by 2, gives -1
  ldr LR, [SP,#0]
  add SP, SP, #8
  mov PC, LR		//checking for startIndex > endIndex

first_else_if:
  ldr r8, [r0, r6, LSL #2]
  cmp r1, r8
  bne	second_else_if
  mov r0, r6
  b return

second_else_if:
  cmp r8, r1
  bgt else //if not bigger than, it is less than, so it just continues below
  add r6, r6, #1
  mov r2, r6
  bl binary_search
  b return

else:
  sub r6, r6, #1
  mov r3, r6
  bl binary_search
  B return

return:
  ldr r5, [SP, #12]
  ldr r4, [SP,#8]
  sub r4, r4, r4, LSL#1 //subtracting numcalls by 2x numcalls, gives -numcalls
  str r4, [r5, r5, LSL#2]

//replenish the registers
  pop   {r4-r8, lr}
  mov PC, LR //returns the value to main
