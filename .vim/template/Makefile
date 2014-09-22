## (File name: )
## Author: SENOO, Ken
## (Last update: )

FC=# gfortran
CC=# gcc
CXX= g++
COMPILER+=$(FC) $(CC) $(CXX)
## flag (compile option) and library
LDFLAGS= -g -MMD -MP -mcmodel=large

TARGET=out.exe

ifdef FC
	SRC:=$(wildcard *.f90)
	OBJ:=$(SRC:%.f90=%.o)
	DEP:=$(SRC:%.f90=%.d)
  MOD:=$(wildcard *.mod)
	FFLAGS=-cpp
endif
ifdef CC
	SRC:=$(wildcard *.c)
	OBJ:=$(SRC:%.c=%.o)
	DEP:=$(SRC:%.c=%.d)
	CFLAGS=
endif
ifdef CXX
	SRC:=$(wildcard *.cpp)
	OBJ:=$(SRC:%.cpp=%.o)
	DEP:=$(SRC:%.cpp=%.d)
	CXXFLAGS=
endif

LDFLAGS+=$(FFLAGS) ${CFLAGS} ${CPPFLAGS}


all: ${TARGET}

${TARGET}: ${OBJ}
	${COMPILER} -o $@ ${LDFLAGS} $^

%.o: %.f90
	${FC} ${LDFLAGS} -c $<
%.o: %.c
	${CC} ${LDFLAGS} -c $<
%.o: %.cpp 
	${CXX} ${LDFLAGS} -c $<


clean:
	rm -f ${TARGET} ${OBJ} ${MOD}

-include $(DEP)
.PHONY: all clean
