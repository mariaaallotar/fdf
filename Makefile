NAME	= fdf
#CFLAGS	= -Wextra -Wall -Werror
LIBMLX	= ./MLX42

HEADERS	= -I ./include -I $(LIBMLX)/include
#linux
#LIBS	= $(LIBMLX)/build/libmlx42.a -ldl -lglfw -pthread -lm
#mac
LIBS	= $(LIBMLX)/build/libmlx42.a -framework Cocoa -framework OpenGL -framework IOKit -Iinclude -lglfw -L"/opt/homebrew/Cellar/glfw/3.3.8/lib/"
SRCS	= main.c
OBJS	= ${SRCS:.c=.o}

all: libmlx $(NAME)

libmlx:
	cmake $(LIBMLX) -B $(LIBMLX)/build && make -C $(LIBMLX)/build -j4

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $< $(HEADERS)

$(NAME): $(OBJS)
	$(CC) $(OBJS) $(LIBS) $(HEADERS) -o $(NAME)

clean:
	rm -rf $(OBJS)
	rm -rf $(LIBMLX)/build

fclean: clean
	rm -rf $(NAME)

re: clean all

.PHONY: all, clean, fclean, re, libmlx
