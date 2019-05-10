NAME = computorv2
CC = g++
SRC = src/parser.cpp src/lex.cpp main.cpp
OBJ = $(SRC:.cpp=.o)
CFLAGS = -c -O0 -std=c++11 #-Wall -Wextra -Werror
HEADERS = headers/parser.hpp

all: $(NAME)

PARSER:
	@bison -d parser.ypp -o src/parser.cpp
	@mv src/parser.hpp headers/parser.hpp
	@flex -l -i --outfile=src/lex.cpp lexer.lex

$(NAME) : PARSER $(OBJ) $(HEADERS)
	@$(CC) $(OBJ) -lfl $(HEADERS) -o $(NAME)
	@echo "\033[0;36m$(NAME) is compiled\033[0m"


src/%.o : %.cpp $(HEADERS)
	@$(CC) $(CFLAGS) $<

clean:
	@rm -f $(OBJ)
	@rm -f src/lex.cpp
	@rm -f src/parser.cpp
	@rm -f headers/parser.hpp

fclean: clean
	@rm -rf $(NAME)

re: fclean all
