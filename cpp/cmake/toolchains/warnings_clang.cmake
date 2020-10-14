# The MIT License (MIT)
#
# Copyright (c) 2016 Mateusz Pusz
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

include("${CMAKE_CURRENT_LIST_DIR}/utils.cmake")

set(CLANG_WARNINGS
    -Wall
    -Wextra # reasonable and standard
    -Wpedantic # warn if non-standard C++ is used
    -Wshadow # warn the user if a variable declaration shadows one from a parent context
    -Wunused # warn on anything being unused
    -Wnull-dereference # warn if a null dereference is detected
    -Wold-style-cast # warn for c-style casts
    -Wcast-align # warn for potential performance problem casts
    -Wcast-qual # warn on dropping const or volatile qualifiers
    -Wconversion # warn on type conversions that may lose data
    -Wsign-conversion # warn on sign conversions
    -Wdouble-promotion # warn if float is implicit promoted to double
    -Wformat=2 # warn on security issues around functions that format output (ie printf)
    -Wnon-virtual-dtor # warn the user if a class with virtual functions has a
                    # non-virtual destructor. This helps catch hard to
                    # track down memory errors
    -Woverloaded-virtual # warn if you overload (not override) a virtual function
)
set(CLANG_WARNINGS ${CLANG_WARNINGS} -Werror)

set_warnings(${CLANG_WARNINGS})
