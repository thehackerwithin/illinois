
# Optimizing (Python) code
#### By Josh Vita (jvita2@illinois.edu)

Many of us are students developing various scripts or packages (often in Python) either as the core of a thesis project or as a useful tool to help with our research. While it's not a big deal to take a quick coffee break while your code runs for 15 minutes, this presentation is intended to help you avoid awkward conversations with your advisor because you've been waiting 3 days for some results.

This presentation will be broken down into 3 main parts:

* Things you should always do because they're easy and good practice
* Things you will often want to do, especially in scientific applications
* Things you only need to do when it's **gotta** go fast

## Things you should always do because they're easy and good practice

* Use list/dict/tuple comprehension
* Take advantage of standard packages and pre-defined functions when possible
* Use generators (where appropriate)

**Each of these has it's own purpose, but in general you can remember that:**
* List comprehensions should be your go-to in most cases due to speed and readability
* `map()` is particularly handy if your function is already defined or you need to avoid memory issues
* For loops are perfectly fine, especially if you're not trying to build a list out of the results

For more details about comparing list comprehension, loops, and `map()`, see [this stackoverflow post]( https://stackoverflow.com/questions/1247486/list-comprehension-vs-map); the top 2 answers are particularly insightful


```python
%%timeit

# In this case, the function is already defined
xs = range(10)
lst = [hex(x) for x in xs]
```

    2.81 µs ± 34.3 ns per loop (mean ± std. dev. of 7 runs, 100000 loops each)



```python
%%timeit

# map() can be slightly better in this case
xs = range(10)
lst = list(map(hex, xs))
```

    2.55 µs ± 8.58 ns per loop (mean ± std. dev. of 7 runs, 100000 loops each)



```python
%%timeit

# This time, we don't have a pre-defined function
xs = range(10)
lst = [x + 2 for x in xs]
```

    1.65 µs ± 12.7 ns per loop (mean ± std. dev. of 7 runs, 1000000 loops each)



```python
%%timeit

# map() incurs an extra overhead due to repeatedly calling the lambda
xs = range(10)
lst = list(map(f, xs))
```

    1.64 µs ± 60.4 ns per loop (mean ± std. dev. of 7 runs, 1000000 loops each)


Beyond built-in functions, many standard libraries provide fast, efficient functions for some common operations. Not only will these save you in terms of development time (arguably more important than runtime), but they'll probably perform better than _I_ could write.

**Here are some handy libraries that I use frequently:**
* [itertools](https://docs.python.org/3/library/itertools.html) -- great for permutations/combinations, and anything involving looping over things
* [glob](https://docs.python.org/3/library/glob.html) -- for accessing files
* [random](https://docs.python.org/3/library/random.html) -- for all things related to random numbers

For a comprehensive list, check out [the collection of standard libraries](https://docs.python.org/3/library/) that come with Python 3


```python
# getting permutations of items in a list -- stuff like this is what makes Python so fun
import itertools

list_of_chars = ['A', 'B', 'C']

# cool, he used generators, list comprehension, built-in functions [str().join()], AND standard libraries all in one example!

["".join(p) for p in itertools.permutations(list_of_chars)]
```




    ['ABC', 'ACB', 'BAC', 'BCA', 'CAB', 'CBA']




```python
# extracting all file names with a given pattern
import glob

print(glob.glob('./glob_folder/*'))
print(glob.glob('./glob_folder/file*_input.dat'))
print(glob.glob('./glob_folder/file1_*.dat'))
```

    ['./glob_folder/file1_input.dat', './glob_folder/file1_output.dat', './glob_folder/file2_input.dat', './glob_folder/file2_output.dat', './glob_folder/file3_input.dat', './glob_folder/file3_output.dat', './glob_folder/README.txt']
    ['./glob_folder/file1_input.dat', './glob_folder/file2_input.dat', './glob_folder/file3_input.dat']
    ['./glob_folder/file1_input.dat', './glob_folder/file1_output.dat']



```python
# sampling a list in random order
import random

random.sample(range(100), 10)
```




    [50, 5, 69, 22, 87, 86, 29, 55, 49, 51]



Generators can be thought of as a way of generalizing the benefits mentioned for `map()`

**In particular, generators can be good because they:**
* Avoid loading large lists into memory (see [this portion of a Youtube video](https://www.youtube.com/watch?v=OSGv2VnC0go&t=8m17s) where one of the core Python developers discusses the importance of keeping calculations in L1 cache)
* Can serve as simple, efficient, and readable replacements for iterators


```python
# This code would create a disastrously large list ...

# lst = [x**x for x in range(10*100)] 
```


```python
# ... but THIS code is perfectly happy!

(x**x for x in range(10*1)) # changing [] to () makes it a 'generator expression'
```




    <generator object <genexpr> at 0x7f25ec305990>




```python
# Here's an example of an iterator for creating a sequence of powers of two

class PowTwo:
    # code from blog post: https://www.programiz.com/python-programming/generator
    
    def __init__(self, max = 0):
        self.max = max

    def __iter__(self):
        self.n = 0
        return self

    def __next__(self):
        if self.n > self.max:
            raise StopIteration

        result = 2 ** self.n
        self.n += 1
        return result
```


```python
# A generator is much simpler -- it's a function with 'yield' instead of 'return'!

def PowTwoGen(max = 0):
    n = 0
    while n < max:
        yield 2 ** n
        n += 1
```


```python
# The same blog post also has a cool example of pipelining using generators

def pipeline():
    
    with open('sells.log') as file:
        pizza_col = (line[3] for line in file)
        per_hour = (int(x) for x in pizza_col if x != 'N/A')
        print("Total pizzas sold = ", sum(per_hour))
```

### Things you'll often want to do, especially in scientific applications
* **Vectorize your code** ... unless it's too hard -- if you're working with numbers in an array, NumPy can do pretty much everything
* Parallelize your code -- some code is "embarrassingly parallel" and just needs some quick imports

"Vectorizing" code refers to trying to structure your code in such a way that you can perform the same operation on multiple parts of a vector at the same time. For Python, this is often translated to "stuff your data into an array, then let NumPy go nuts".

**Here are some tips if you're trying to vectorize your code:**
* First, profile your code using [some of the common libraries](https://docs.python.org/3/library/profile.html) to make sure it's worth your time -- I can't over-emphasize the importance of this
* Learn about NumPy broadcasting and [how to use np.newaxis](https://medium.com/@ian.dzindo01/what-is-numpy-newaxis-and-when-to-use-it-8cb61c7ed6ae)
* Check out the NumPy documentation for handy functions -- my favorite is [`np.einsum`](https://docs.scipy.org/doc/numpy-1.14.0/reference/generated/numpy.einsum.html)
* Familiarize yourself with NumPy's [Universal Functions](https://jakevdp.github.io/PythonDataScienceHandbook/02.03-computation-on-arrays-ufuncs.html)

Below is an example from [this blog post](https://datafireball.com/2016/07/24/python-profiling-cprofile/) showing the benefits of profiling.

**Before trying to optimize, _always_ spend some time making sure it's worth the effort**
![an example using cProfile](cprofile.png)


```python
import numpy as np
```


```python
A = np.arange(210000).reshape((50, 60, 70))
sums = np.zeros(60)
```


```python
%%timeit

# loops can be horribly slow, especially for high-dimensional matrices
for j in range(A.shape[1]):
    for i in range(A.shape[0]):
        for k in range(A.shape[2]):
            sums[j] += A[i, j, k]
```

    162 ms ± 1.58 ms per loop (mean ± std. dev. of 7 runs, 10 loops each)



```python
%%timeit

# NumPy is way faster since it's calling optimized C libraries
sums = np.sum(A, axis=(0, 2))
```

    312 µs ± 1.37 µs per loop (mean ± std. dev. of 7 runs, 1000 loops each)


A minor point, but when I first started programming in Python I always used to make the mistake of trying to grow NumPy arrays dynamically. This is noticeably slower and can have a significant impact for large matrices.


```python
%%timeit

# A naive example of building an array where each row is double the previous row
A = np.arange(1000).reshape((1, 1000))

for i in range(19):
    A = np.vstack([A, A[-1]*2])
```

    393 µs ± 15.2 µs per loop (mean ± std. dev. of 7 runs, 1000 loops each)



```python
%%timeit

# defining the full array ahead of time helps significantly
A = np.zeros(20000).reshape((20, 1000))
A[0] = np.arange(1000)

for i in range(1, 20):
    A[i, :] = A[i - 1, :]*2
```

    113 µs ± 1.22 µs per loop (mean ± std. dev. of 7 runs, 10000 loops each)


An example of vectorization in my work that groups element-wise multiplication along an axis followed by summation and an axis swap ... all into one call 

`embedding_forces = np.einsum('pijk,pk->pji', embedding_forces, uprimes)`

For many problems, one of the easiest speedups can come from simply parallelizing your code. In the case of shared-memory problems, the [multiprocessing](https://docs.python.org/2/library/multiprocessing.html) module is a godsend.

**The multiprocessing module can be a quick fix when:**
* You need to perform the same operations on different chunks of data (SIMD)

multiprocessing can be used in a number of different cases; I won't show an example here, but there are plenty of examples online such as [this one](https://stackoverflow.com/questions/20887555/dead-simple-example-of-using-multiprocessing-queue-pool-and-locking).

Note: if you're going to be doing lots of parallel computing in Python, you should check out [this presentation](https://www.dabeaz.com/python/UnderstandingGIL.pdf) by one of the major players in the Python community discussing the Global Interpreter Lock (GIL).

### Things you only need to do when it's _gotta_ go fast
* JIT compilation using [Numba](https://numba.pydata.org/numba-doc/dev/user/5minguide.html)
* Write your own libraries in C/C++, then use something like [cython](https://medium.com/@shamir.stav_83310/making-your-c-library-callable-from-python-by-wrapping-it-with-cython-b09db35012a3) to call the library from python


[This blog post](https://www.ibm.com/developerworks/community/blogs/jfp/entry/A_Comparison_Of_C_Julia_Python_Numba_Cython_Scipy_and_BLAS_on_LU_Factorization?lang=en) provides some nice statistics looking at Numba performance on LU factorization![Comparing Numba to C for LU factorization](numba_performance.png)


```python
from numba import jit, void, double

def numpy_det_by_lu(y, x):
    y[0] = 1.

    N = x.shape[0]
    with np.errstate(invalid='ignore'):
        for k in range(N):
            y[0] *= x[k,k]
            xk = x[k]
            for i in range(k+1, N):
                xi = x[i]
                xi[k] /= xk[k]
                xi[k+1:] -= xi[k] * xk[k+1:]
                
fastdet_by_lu = jit(void(double[:], double[:,:]))(numba_det_by_lu)
```

    


### Other useful stuff
* Time-resolved memory usage using [memory-profiler](https://pypi.org/project/memory-profiler/)
* [Some performance metrics](https://stackoverflow.com/questions/3055477/how-slow-is-pythons-string-concatenation-vs-str-join) on why you should use `''.join()` over `+` for string construction
* Distributed-memory parallelization using [mpi4py](https://mpi4py.readthedocs.io/en/stable/)


```python

```
