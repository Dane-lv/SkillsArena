#── Compiler & flags
CC          := gcc
CFLAGS      := -Wall -Wextra -std=c11 -Ilib/include
SDL_CFLAGS  := -I/opt/homebrew/include -I/opt/homebrew/include/SDL3 -I/opt/homebrew/include/SDL3_ttf
SDL_LDFLAGS := -L/opt/homebrew/lib -lSDL3 -lSDL3_ttf


#── Source files
CLIENT_SRC  := client/src/main.c
SERVER_SRC  := server/main.c
LIB_SRCS    := $(wildcard lib/src/*.c)

#── Object files
CLIENT_OBJS := $(CLIENT_SRC:.c=.o) $(LIB_SRCS:.c=.o)
SERVER_OBJS := $(SERVER_SRC:.c=.o) $(LIB_SRCS:.c=.o)

#── Output binaries in project root
CLIENT_BIN  := clientapp
SERVER_BIN  := serverapp

#── Default target
.PHONY: all
all: $(CLIENT_BIN) $(SERVER_BIN)

#── Link client (with SDL + TTF)
$(CLIENT_BIN): $(CLIENT_OBJS)
	$(CC) $(CFLAGS) $(SDL_CFLAGS) $^ -o $@ $(SDL_LDFLAGS)

#── Link server (also with SDL if needed)
$(SERVER_BIN): $(SERVER_OBJS)
	$(CC) $(CFLAGS) $(SDL_CFLAGS) $^ -o $@ $(SDL_LDFLAGS)

#── Compile any .c --> .o
%.o: %.c
	$(CC) $(CFLAGS) $(SDL_CFLAGS) -c $< -o $@

#── Clean up
.PHONY: clean
clean:
	rm -f $(CLIENT_OBJS) $(SERVER_OBJS) $(CLIENT_BIN) $(SERVER_BIN)
