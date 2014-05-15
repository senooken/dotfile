## Makefile
## @author: SENOO, Ken
## (Last Update: )

FC=gfortran
CC=gcc
CPP=g++

TARGET=out.exe
OBJ=
MOD=

## flag (compile option) and library
FFLAGS=
CFLAGS=
CPPFLAGS=
LDFLAGS=


%.o: %.cpp # c, cpp, f90
	${CPP} -c $<
#	${CC} -c $<
#	${FC} -c $<

${TARGET}: ${OBJ}
	${CPP} -o $@ ${OBJ} ${LDFLAGS} ${CPPFLAGS}
#	${CC} -o $@ ${OBJ} ${LDFLAGS} ${CFLAGS}
#	${FC} -o $@ ${OBJ} ${LDFLAGS} ${FFLAGS}

.PHONY: clean
clean:
	rm -rf ${TARGET} ${OBJ} ${MOD}

