NAME = libasm.a

TEST = program

OBJ_DIR = obj
BIN_DIR = bin

ASM = nasm
ASMFLAGS = -f elf64 -DPIC

AR = ar
ARFLAGS = rcs

CC = gcc
CFLAGS = -Wall -Werror -Wextra

SRCS_DIR = srcs

SRCS = ft_strlen.s ft_strcpy.s ft_write.s ft_read.s ft_strcmp.s

OBJS = $(addprefix $(OBJ_DIR)/, $(SRCS:.s=.o))

MAIN_SRC = main.c
MAIN_OBJ = $(OBJ_DIR)/$(MAIN_SRC:.c=.o)

GREEN = \033[0;32m
BLUE = \033[0;34m
RED = \033[0;31m
RESET = \033[0m

all: $(BIN_DIR)/$(NAME)

$(BIN_DIR)/$(NAME): $(OBJS) | $(BIN_DIR)
	@echo "$(BLUE)Creating library $(NAME)...$(RESET)"
	$(AR) $(ARFLAGS) $(BIN_DIR)/$(NAME) $(OBJS)
	@echo "$(GREEN)✓ $(NAME) created successfully!$(RESET)"

$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.s | $(OBJ_DIR)
	@echo "$(BLUE)Assembling $<...$(RESET)"
	$(ASM) $(ASMFLAGS) $< -o $@

# $(OBJ_DIR)/%.o: %.s | $(OBJ_DIR)
# 	@echo "$(BLUE)Assembling $<...$(RESET)"
# 	$(ASM) $(ASMFLAGS) $< -o $@
	
$(OBJ_DIR)/%.o: %.c | $(OBJ_DIR)
	@echo "$(BLUE)Compiling $<...$(RESET)"
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN_DIR)/$(TEST): $(BIN_DIR)/$(NAME) $(MAIN_OBJ) | $(BIN_DIR)
	@echo "$(BLUE)Linking $(TEST)...$(RESET)"
	$(CC) $(MAIN_OBJ) -L$(BIN_DIR) -lasm -o $(BIN_DIR)/$(TEST)
	@echo "$(GREEN)✓ $(TEST) created successfully!$(RESET)"

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

test: $(BIN_DIR)/$(TEST)
	@echo "$(GREEN)Running tests...$(RESET)"
	./$(BIN_DIR)/$(TEST)

clean:
	@echo "$(RED)Cleaning object files...$(RESET)"
	rm -rf $(OBJ_DIR)
	@echo "$(GREEN)✓ Clean done!$(RESET)"

fclean: clean
	@echo "$(RED)Removing $(BIN_DIR)...$(RESET)"
	rm -rf $(BIN_DIR)
	@echo "$(GREEN)✓ Full clean done!$(RESET)"

re: fclean all

info:
	@echo "$(BLUE)========================================"$(RESET)"
	@echo "$(BLUE)Project: libasm$(RESET)"
	@echo "$(BLUE)Library: $(NAME)$(RESET)"
	@echo "$(BLUE)Test program: $(TEST)$(RESET)"
	@echo "$(BLUE)Sources:$(RESET)"
	@for src in $(SRCS); do echo "  - $$src"; done
	@echo "$(BLUE)========================================"$(RESET)"

.PHONY: all clean fclean re test info