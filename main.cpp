#include <iostream>
#include "headers/parser.hpp"
#include <string>

void    scan_string(const char* str);
void    clear_buffer(void);

int     main(const int argc, const char* argv[])
{
    if (argc == 1) {
        std::string         str;
        int                 res;

        while (std::getline(std::cin, str)) {
            scan_string(str.c_str());
            res = yyparse();
            clear_buffer();
        }
        return (0);
    }
    else {
        std::cerr << "Program doesn't take any parameters" << std::endl;
        return (1);
    }
}
