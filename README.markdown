# cl-clblas

[![Quicklisp](http://quickdocs.org/badge/cl-clblas.svg)](http://quickdocs.org/cl-clblas/)
[![CircleCI Status](https://circleci.com/gh/gos-k/cl-clblas.svg?style=shield)](https://circleci.com/gh/gos-k/cl-clblas)
[![TravisCI Status](https://travis-ci.org/gos-k/cl-clblas.svg?branch=master)](https://travis-ci.org/gos-k/cl-clblas)

cl-clblas is a Common Lisp binding for [clBLAS](https://github.com/clMathLibraries/clBLAS).

## Usage

```
(ql:quickload :cl-clblas)
```

## Installation

### Ubuntu 16.10 and Roswell

Install clBLAS.

```
apt-get install libclblas-dev
```

Clone cl-clblas to local-projects.

```
ros install gos-k/cl-clblas
```

## Requirements

* clBLAS 2.10
* SBCL 1.3.11

## Author

* gos-k (mag4.elan@gmail.com)

## Copyright

Copyright (c) 2016 gos-k (mag4.elan@gmail.com)

## License

Licensed under the Apache License, Version 2.0.
