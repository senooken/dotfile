# (File name: Makefile)
# Author: SENOO, Ken

## choose target compiler
FC = gfortran
CC = gcc
CXX = g++

## unset non target compiler
FC =
CC =
# CXX =

COMPILER = $(FC) $(CC) $(CXX)

## global flag (compile option) and library
LDFLAGS = -g -MMD -MP -mcmodel=large -Wall

TARGET = out.exe

ifdef FC
	SRC := $(wildcard *.f90)
	OBJ := $(SRC:%.f90=%.o)
	DEP := $(SRC:%.f90=%.d)
	MOD := $(wildcard *.mod)
	FFLAGS += -cpp
endif
ifdef CC
	SRC := $(wildcard *.c)
	OBJ := $(SRC:%.c=%.o)
	DEP := $(SRC:%.c=%.d)
	CFLAGS += -lm
endif
ifdef CXX
	SRC := $(wildcard *.cpp)
	OBJ := $(SRC:%.cpp=%.o)
	DEP := $(SRC:%.cpp=%.d)
	CXXFLAGS +=
endif

ifeq (${OS}, Windows_NT) # for Windows
	CFLAGS += --exec-charset=sjis
endif

all: ${TARGET}

${TARGET}: ${OBJ}
	${COMPILER} -o $@ ${LDFLAGS} $^

%.o: %.f90
	${FC} ${LDFLAGS} ${FFLAGS} -c $<
%.o: %.c
	${CC} ${LDFLAGS} ${CFLAGS} -c $<
%.o: %.cpp
	${CXX} ${LDFLAGS} ${CXXFLAGS} -c $<

clean:
	${RM} ${TARGET} ${OBJ} ${DEP} ${MOD}

-include $(DEP)
.PHONY: all clean
