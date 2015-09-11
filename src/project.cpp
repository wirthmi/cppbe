#include <cstdlib>
#include <iostream>

// CXXFLAGS = -DWAY_TO_SET_SOURCE_FILE_SPECIFIC_CXXFLAGS


int main( int argc, char * argv[] ) {

  #ifdef WAY_TO_SET_SOURCE_FILE_SPECIFIC_CXXFLAGS
  std::cout << "Hello, World!" << std::endl;
  #endif

  return EXIT_SUCCESS;
}
