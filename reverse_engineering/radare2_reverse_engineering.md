# Reverse Engineering 

## Introduction to x86-64 Assembly
Computers execute machine code, which is encoded as bytes, to carry out tasks on a computer. Since different computers have different processors, the machine code executed on these computers is specific to the processor. In this case, we’ll be looking at the Intel x86-64 instruction set architecture which is most commonly found today.

Machine code is usually represented by a more readable form of the code called assembly code. This machine is code is usually produced by a compiler, which takes the source code of a file, and after going through some intermediate stages, produces machine code that can be executed by a computer.

## Radare2
The best way to actually start explaining assembly is by diving in. We’ll be using radare2 to do this - radare2 is a framework for reverse engineering and analysing binaries. It can be used to disassemble binaries(translate machine code to assembly, which is actually readable) and debug said binaries.

Let's proceed to run through how Radare2 works exactly.

## Using Radare2
Time to see what’s happening under the hood! Run the command:
	
	r2 -d ./file

This will open the binary in debugging mode. Once the binary is open, one of the first things to do is ask r2 to analyze the program, and this can be done by typing in: 

	aa

Note, when using the aa command in radare2, this may take between 5-10 minutes depending on your system.

Which is the most common analysis command. It analyses all symbols and entry points in the executable. The analysis, in this case, involves extracting function names, flow control information, and much more! r2 instructions are usually based on a single character, so it is easy to get more information about the commands.

I.e. For general help, we can run: ? or if we wish to understand more about a specific feature, we could provide a?

## Analysis 
Once the analysis is complete, you would want to know where to start analysing from - most programs have an entry point defined as main. To find a list of the functions run: afl

As seen here, there actually is a function at main. Let’s examine the assembly code at main by running the command 

	pdf @main 

Where pdf means print disassembly function.


## Assembly
The core of assembly language involves using registers to do the following:

* Transfer data between memory and register, and vice versa
* Perform arithmetic operations on registers and data
* Transfer control to other parts of the program Since the architecture is x86-64, the registers are 64 bit and Intel has a list of 16 registers:

|-------------------|--------|--------------|
| Initial Data Type | Suffix | Size (bytes) |
|-------------------|--------|--------------|
| Byte              | b      | 1            |
| Word              | w      | 2            |
| Double Word       | l      | 4            |
| Quad              | q      | 8            |
| Single Precision  | s      | 4            |
| Double Precision  | l      | 8            |

### Memory Manipulation
When dealing with memory manipulation using registers, there are other cases to be considered:

    (Rb, Ri) = MemoryLocation[Rb + Ri]
    D(Rb, Ri) = MemoryLocation[Rb + Ri + D]
    (Rb, Ri, S) = MemoryLocation(Rb + S * Ri]
    D(Rb, Ri, S) = MemoryLocation[Rb + S * Ri + D]

### Important Instructions
Some other important instructions are:

leaq source, destination: this instruction sets destination to the address denoted by the expression in source
addq source, destination: destination = destination + source
subq source, destination: destination = destination - source
imulq source, destination: destination = destination * source
salq source, destination: destination = destination << source where << is the left bit shifting operator
sarq source, destination: destination = destination >> source where >> is the right bit shifting operator
xorq source, destination: destination = destination XOR source
andq source, destination: destination = destination & source
orq source, destination: destination = destination | source

## Analysing a main function
The line starting with sym.main indicates we’re looking at the main function. The next lines are used to represent the variables stored in the function. The second column indicates their data type, e.g. integers (int). The third column specifies the name that r2 uses to reference them and the fourth column shows the actual memory location. 

### Entry 
Most functions will start with three instructions which are used to allocate space on that stack (ensures that there’s enough room for variables to be allocated and more.

push   %rbp ; Push address of previous stack frame to stack
mov    %rsp, %rbp ; Move the address of the top of the stack to the current stack frame. 
sub    rsp,0x10 ; Reserve 16 bytes for local variables

While %rbp points to the current stack frame, %rsp points to the top of the stack. Because the compiler knows the difference between %rbp and %rsp at any point within the function, it is free to use either one as the base for the local variables.

The last line reserves an amount of memory for the local variables. The amount of memory reserved for the local variables is always a multiple of 16 bytes, to keep the stack aligned to 16 bytes. If no stack space is needed for local variables, there is no sub $16, %rsp or similar instruction.

A lot of compilers offer frame pointer omission as an optimization option; this will make the generated assembly code access variables relative to rsp instead and free up rbp as another general purpose register for use in functions, e.g. using GCC this is done with the flag -fomit-frame-pointer.

This would mean that when accessing values relative to rsp instead of rbp, the offset from the pointer varies throughout the function.

### Breakpoints
After the entry instructions- it's useful to set breakpoints to analyse the state of the program at a particular point. We can do this in radare2 by using the "db" command with the hex value of the instruction, e.g:

	db 0x00400b55

To ensure the breakpoint is set, we run the pdf @main command again and see a little b next to the instruction we want to stop at.

Now that we’ve set a breakpoint, let’s run the program using dc

Running dc will execute the program until we hit the breakpoint. Once we hit the breakpoint and print out the main function, the rip which is the current instruction shows where execution has stopped.

### Viewing Variables
So far our analysis has shown us that this instruction is transferring a value of "4" into the "local_ch" variable. To view the contents of this variable, we can use "px @memory_address" in this case, the corresponding memory address for local_ch wuld be "rbp-0xc" (which we can see from the variable definitions of @pdf main):

	px @rbp-0xc

This instruction prints the values of the memory in hex.

### Stepping
This shows that the variable currently doesn’t have anything stored in it (it’s just 0000). Let’s execute this instruction and go to the next one using the following command (which only goes to the next instruction):

	ds 

If we view the memory location after running this command, we can see that the first 2 bytes have the value 4! If we do the same process for the next instruction, we’ll see that the variable local_8h has the value 5.

### Viewing Registers
If we go to the instruction movl local_8h, %eax, we know from the notes that this moves the value from local_8h to the %eax register. To see the value of the %eax register, we can use the command:

	dr 

Which will list the contents of the registers at that point in the code. 

If we execute the instruction and run the dr command again, we can see that the %eax register now holds the value "5". 

We can do the same for similar instructions and view the values of the registers changing. When we come to the addl %edx, %eax, we know that this will add the values in edx and eax and store them in eax. Running dr shows us the rax contains 5 and rdx contains 4, so we’d expect rax to contain 9 after the instruction is executed:

Executing ds to move to the next instruction then executing dr to view register variable shows us we are correct.

## General Workflow
1. Set appropriate breakpoints
2. Use ds to move through instructions and check the values of register and memory 
3. If you make a mistake, you can always reload the program using the ood command
