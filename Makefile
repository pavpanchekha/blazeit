DEBUG=1
PRINT=0

VPATH=./src/
EXEC=blazeit
OBJDIR=./obj/

CC=gcc
OPTS=-Ofast -flto
LDFLAGS= -lm 
CFLAGS=-Wall -Wfatal-errors 

ifeq ($(DEBUG), 1) 
OPTS=-O0 -g
endif

ifeq ($(PRINT), 1)
CFLAGS+= -DDEBUG 
else
CFLAGS+= -DDEBUG=0
endif

CFLAGS+=$(OPTS)

OBJ=main.o term.o utils.o parser.o environment.o list.o term_list.o tokenizer.o

OBJS = $(addprefix $(OBJDIR), $(OBJ))
DEPS = $(wildcard src/*.h) Makefile

all: obj $(EXEC)

$(EXEC): $(OBJS)
	$(CC) $(COMMON) $(CFLAGS) $^ -o $@ $(LDFLAGS)

$(OBJDIR)%.o: %.c $(DEPS)
	$(CC) $(COMMON) $(CFLAGS) -c $< -o $@

obj:
	mkdir -p obj

.PHONY: clean

clean:
	rm -rf $(OBJS) $(EXEC)

