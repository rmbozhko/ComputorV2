#include "headers/main.hpp"

int     main(const int argc, const char* argv[])
{
    if (argc == 1) {
        
        char*       str;
        int         res;

        while ((str = readline("> ")) != nullptr)
        {
            if (*str)
            {
                scan_string(str);
                res = yyparse();
                clear_buffer();
                add_history(str);
            }
            free(str);
        }
        return (0);
    }
    else {
        std::cerr << "Program doesn't take any parameters" << std::endl;
        return (1);
    }
}
