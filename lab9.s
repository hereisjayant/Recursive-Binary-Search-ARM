 .globl binary_search
binary_search:
//saving the registers
  push   {r4-r8, lr}
  sub R5, R3, R2	  //r5 = endIndex - startIndex
  mov R5, R5, LSR#1 //r5 = r5/2
  add R5, R5, R2    //middleIndex = startIndex + (endIndex - startIndex)/2;
  add R4, R4, #1    //NumCalls++;

  CMP R2, R3        //Compare (startIndex, endIndex)
  ble first_else_if   //branch
  mov R0, #1
  sub R0, R0, R0, LSL#1 //subtracting 1 by 2, gives -1
  ldr LR, [SP,#0]
  add SP, SP, #8
  mov PC, LR		//checking for startIndex > endIndex

first_else_if:
  ldr R8, [R0, R5, LSL #2]
  cmp R1, R8
  bne	second_else_if
  mov R0, R5
  b return

second_else_if:
  cmp R8, R1
  bgt else //if not bigger than, it is less than, so it just continues below
  add R5, R5, #1
  mov R2, R5
  bl binary_search
  b return

else:
  sub R5, R5, #1
  mov R3, R5
  bl binary_search
  B return

return:
  ldr R6, [SP, #12]
  ldr R4, [SP,#8]
  sub R4, R4, R4, LSL#1 //subtracting numcalls by 2x numcalls, gives -numcalls
  str R4, [R6, R5, LSL#2]

//replenish the registers
  pop   {r4-r8, lr}
  mov PC, LR //returns the value to main
