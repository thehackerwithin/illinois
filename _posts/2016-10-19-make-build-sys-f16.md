---
layout: post
title: Make, CMake, Docker, & Vagrant - Making it easier to build software
author: Gregory Hart, Katy Huff, Alex Lindsay
category: posts
tags: meeting,make,cmake,docker
---

## Meeting Info
* Date: {{ page.date | date: '%B %d, %Y' }}
* Time: 12:00 PM
* Location: [2000 NCSA][ncsa_map]

## Technical: Make, CMake, Docker
[Greg Hart][greg]
[Alex Lindsay][alex]
[Katy Huff][katy]

Make Introduction
=========================

Make is software that allows you to carry out a series of tasks in a way that respects the dependencies amongst files or tasks. While it was develovoped for bulding software (i.e. compiling C++ code, linking the files, and placing the executable) It can be used for more then that. The Make manual states "You can use make with any programming language whose compiler can be run with a shell command. Indeed, make is not limited to programs. You can use it to describe any task where some files must be updated automatically from others whenever the others change." I will cover the basics of Make and give an idea of how powerful and complex it can be.


### Basic Makefile

Here is a basic make file:

~~~
$cat Makefile
test: test.o anotherTest.o
        gcc -Wall test.o anotherTest.o -o test

test.o: test.c
        gcc -c -Wall test.c

anotherTest.o: anotherTest.c
        gcc -c -Wall anotherTest.c

clean:
        rm -rf *.o test
~~~

Now running make will compile both .c files and link them into the executable test:

~~~
$make
gcc -c -Wall test.c
gcc -c -Wall anotherTest.c
gcc -Wall test.o anotherTest.o -o test
~~~

Here is what is happening. When you run make it looks for a file named Makefile in the current directory and looks at the first target (thing/name on the left of the colon). It then "makes" this target by running the associated command(s) (the indented line(s) following the target) after checking the prerequisites (the things/names after the colon).This checking can lead to other targets being made.

Here specifically the target test depends on test.o and anotherTest.o so make checks for files/targets with these names. It finds the targets test.o and anotherTest.o and then checks their prerequisites test.c and anotherTest.c, but there are no targets for test.c or anotherTest.c so the rules are executed. Make checks if test.o's time stape is older then test.c's since test.o doesn't exist its timestamp is older and the rule is run (the indented lines executed). The same happens for anotherTest.o. With these prerequistites taken care of make goes back to the rule for test and makes it since test is "older" then it's prerequisites.

Since rules are only executed if the prerequites have changed since the target was made if we run make again nothing will happen:

~~~
$make
make: Nothing to be done for `test'.
~~~

Make makes incremental builds by only building targets if something changed that effects them. For example if we edit test.c and run make:

~~~
$ make
gcc -c -Wall test.c
gcc -Wall test.o anotherTest.o -o test
~~~

anotherTest.o isn't recompiled because the changes to test.c do not affect it. For this simple example this is not a big deal, but for more complicated projects this can save a lot of time.

Make automatically builds the first target in the file. However you can specify the target by listing it after make (i.e. make clean). It is very common to have a makefile (such as this exmaple) with a target executable and a clean target that deletes the executable and all the .o files. Often clean is used if you want to rebuild everything regradless of when files were edited, however the -B option unconditionally makes all targets. If your makefile is not named Makefile use -f __file__. If your makefile (and everything else) is not in the working directory use -C __dir__. Make will actually switch to this directory and run then switch back. 

### Adding variables

In a makefile you can use varibles. The are declered like this:

CXX = g++

and are used like this:

$(CXX)

~~~
$cat Makefile
CC = gcc
Warnings = -Wall

test: test.o anotherTest.o
        $(CC) $(Warnings) test.o anotherTest.o -o test

test.o: test.c
        $(CC) -c $(Warnings) test.c

anotherTest.o: anotherTest.c
        $(CC) -c $(Warning) anotherTest.c

clean:
        rm -rf *.o test
~~~

With these varables we only have to edit one line if we want to change the compiler or turn off the warnings by commenting out the line that defines Warnings. Alternately we could add a -g to the variable Warnings if we wanted to debug our code.

There are magic variables that are important to know about. The above file could be rewritten as:

~~~
$cat Makefile
CC = gcc
Warnings = -Wall

test: test.o anotherTest.o
        $(CC) $(Warnings) $^ -o $@

test.o: test.c
        $(CC) -c $(Warnings) $<

anotherTest.o: anotherTest.c
        $(CC) -c $(Warning) $<

clean:
        rm -rf *.o test
~~~

Here $@ becomes the target, $< is the first prerequesite, and $^ is all the prerequisites. This has made the file less readable, but doesn't offer any benefit in this simiple example.

### A More complicated example

Here is a "real" makefile based on one from my research:

~~~
CXX = g++
DEBUG = n
USE_OMP = n
CXXFLAGS = -O2 -I/share/apps/include -I./include -I/usr/lib64 -I/usr/lib64/atlas -DUSE_BLAS -DUSE_LAPACK
LIBS = -L/share/apps/lib -l:libtrng4.a -L./lib -lblas /usr/lib64/atlas/liblapack.so
CXXLDFLAGS = -O2

#if DEBUG is set to y add debug flags to CXXFLAGS
ifeq ($(DEBUG),y)
        CXXFLAGS += -DDEBUG
        CXXFLAGS += -g
endif

#if USE_OMP is set to y add libraries for OMP
ifeq ($(USE_OMP),y)
        CXXFLAGS += -fopenmp
        LIBS += -lgomp
endif

#create a variable, CPPS, with all the files in the directory that end in .cpp
CPPS = $(wildcard *.cpp)
#create a variable, OBJS, with the extensions to the sorce files changed from .cpp to .o
OBJS = $(CPPS:.cpp=.o)
#create a list of the file names without extensions
SOURCE = $(foreach file,$(CPPS),$(notdir $(basename $(file))))

#create the executable dependent on all the object files
PottsOMP: $(OBJS)
        $(CXX) $(CXXLDFLAGS) $(OBJS) -o $@ $(LIBS)

#From each .cpp file in the directory create a rule for a .o file of the same name dependent on this .cpp file. There is another (deprecated) way of doing this .cpp.o:
%.o: %.cpp
        $(CXX) $(CXXFLAGS) -c $<

clean:
        rm -f PottsOMP *.exe *.o *~

#This target creates a file, depends.mk, with the depencies for each .o file. This saves one the trouble of trying to keep track of the .h files themselves.
depends : 
	@ rm -f depends.mk
	@ for f in $(SOURCE); do $(CXX) -MM $$f.cpp -MT $$f.o >> depends.mk; done

#include the file created by the above target
include depend.mk

$cat depend.mk
main.o: main.cpp main.h functions.h ran2.h mersenne.h grid.h blas.h lapack.h
functions.o: functions.cpp functions.h ran2.h
ran2.o: ran2.cpp ran2.h
mersenne.o: mersenne.cpp mersenne.h
grid.o: grid.cpp grid.h
~~~

Here I am defining a number of variables to set the compiler and compiler flags. Then I create a list of all the .cpp files in this directory and create a corresponding list of .o files. Next is the target for the executable. The next is strange but powerful. Here the % acts as a wildcard and we get a target for very .cpp file in the directory. This way we do not have to write out the rules for each file. It does not matter if the number of files change. We will have a rule for each one. Next I have the standard clean target. Next is a line creating a seperate file with depences and then an include line to include this file.

=================

## Other uses for Make

Many people like to mention that Make can be used for things other than compiling code. However it is very hard to find any examples of this. Several people mention using it to manage a website but I couldn't find any examples of that. [This](http://stackoverflow.com/questions/395234/any-interesting-uses-of-makefiles-to-share) stackover posts talks about using Make for parallel bash scripts.

[Mike Bostock](https://bost.ocks.org/mike/make/) says, "Makefiles are machine-readable documentation that make your workflow reproducible". He suggests using them for downloading data, processing data, and making plots.


## CMake

Katy will start with [the official CMake 
tutorial](https://cmake.org/cmake-tutorial/) and will then skim two examples of 
real-world CMake use (Cyclus and HDF5). 

## Lightning Talks:

## Attendance

<+how many+>


[ncsa_map]: http://illinois.edu/map/view?skinId=0&ACTION=MAP&buildingId=564
[greg]: {{site.url}}/_people/Gregory_Hart.html
[alex]: {{site.url}}/_people/Alex_Lindsay.html
[katy]: http://kdhuff.web.engr.illinois.edu

