NAME	= fdf
#CFLAGS	= -Wextra -Wall -Werror
LIBMLX	= ./MLX42

LIBFT = libft/libft.a
LIBFT_MAKEFILE = libft/Makefile
LIBFT_DIR = ./libft

HEADERS	= -I ./include -I $(LIBMLX)/include
#linux
LIBS	= $(LIBMLX)/build/libmlx42.a -ldl -lglfw -pthread -lm
#mac
#LIBS	= $(LIBMLX)/build/libmlx42.a -framework Cocoa -framework OpenGL -framework IOKit -Iinclude -lglfw -L"/opt/homebrew/Cellar/glfw/3.3.8/lib/"
SRCS	= main.c
OBJS	= ${SRCS:.c=.o}

all: libmlx $(LIBFT) $(NAME)

libmlx:
	cmake $(LIBMLX) -B $(LIBMLX)/build && make -C $(LIBMLX)/build -j4

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $< $(HEADERS)

$(NAME): $(OBJS) libft
	$(CC) $(OBJS) $(LIBS) $(HEADERS) $(LIBFT) -o $(NAME)

$(LIBFT):
	echo "Should make libft"
	make -C $(LIBFT_DIR)

clean:
	rm -rf $(OBJS)
	rm -rf $(LIBMLX)/build
	make -C $(LIBFT_DIR) clean

fclean: clean
	rm -rf $(NAME)
	make -C $(LIBFT_DIR) fclean

re: fclean all

.PHONY: all, clean, fclean, re, libmlx
