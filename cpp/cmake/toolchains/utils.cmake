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

function(add_cache_flag var_name flag)
  set(spaced_string " ${${var_name}} ")
  string(FIND "${spaced_string}" " ${flag} " flag_index)
  if(NOT flag_index EQUAL -1)
    return()
  endif()
  string(COMPARE EQUAL "" "${${var_name}}" is_empty)
  if(is_empty)
    set("${var_name}" "${flag}" CACHE STRING "" FORCE)
  else()
    set("${var_name}" "${flag} ${${var_name}}" CACHE STRING "" FORCE)
  endif()
endfunction()

function(set_warnings)
  foreach(arg ${ARGN})
    add_cache_flag(CMAKE_CXX_FLAGS ${arg})
  endforeach()
endfunction()
