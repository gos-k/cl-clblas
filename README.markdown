# cl-clblas

[![TravisCI Status](https://travis-ci.org/gos-k/cl-clblas.svg?branch=master)](https://travis-ci.org/gos-k/cl-clblas)
[![Quicklisp](http://quickdocs.org/badge/cl-clblas.svg)](http://quickdocs.org/cl-clblas/)

cl-clblas is a Common Lisp binding for [clBLAS](https://github.com/clMathLibraries/clBLAS).

## Usage

```
(ql:quickload :cl-clblas)
```

## Installation

### Ubuntu 15.10 and Roswell

Install clBLAS.

```
apt-get install libclblas-dev
```

Clone cl-clblas to local-projects.

```
git clone https://github.com/gos-k/cl-clblas ~/.roswell/local-projects/cl-clblas
```

## Requirements

* clBLAS 2.6
* SBCL 1.3.8

## Author

* gos-k (mag4.elan@gmail.com)

## Copyright

Copyright (c) 2016 gos-k (mag4.elan@gmail.com)

## License

Licensed under the Apache License, Version 2.0.
