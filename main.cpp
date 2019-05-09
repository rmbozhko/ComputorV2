#include <iostream>
#include "headers/parser.hpp"

int     main(const int argc, const char* argv[])
{
    if (argc == 1) {
        std::cout << "Running program .." << std::endl;
        return (0);
    }
    else {
        std::cerr << "Program doesn't take any parameters" << std::endl;
        return (1);
    }
}
