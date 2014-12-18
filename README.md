libparser.pl
============

A simple script that expands #include directives in C++ source code.
Expands only includes with quoted names. (e.g #include "test.h").

Usage
-----

./libparser.pl lib_directory source output

Where "lib_directory" is directory which contains
your include files. "source" is name of C++ source file.
And "output" is name of output source file that should be produced
by this script.

For example:
./libparser.pl ~/projects/algo_library/ test.cpp output.cpp