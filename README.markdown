# cl-clblas

[![Quicklisp](http://quickdocs.org/badge/cl-clblas.svg)](http://quickdocs.org/cl-clblas/)
<!--
[![CircleCI Status](https://circleci.com/gh/gos-k/cl-clblas.svg?style=shield)](https://circleci.com/gh/gos-k/cl-clblas)
[![TravisCI Status](https://travis-ci.org/gos-k/cl-clblas.svg?branch=master)](https://travis-ci.org/gos-k/cl-clblas)
-->

cl-clblas is a Common Lisp binding for [clBLAS](https://github.com/clMathLibraries/clBLAS).

## Usage

```
(ql:quickload :cl-clblas)
```

## Installation

### Ubuntu 16.04 and Roswell

Install clBLAS.

```
apt-get install libclblas-dev
```

Install cl-clblas.
```
ros install gos-k/cl-clblas
```

## Test

```
(ql:quickload :cl-clblas-test)
(prove:run :cl-clblas-test)
```

## Requirements

* clBLAS 2.10
* SBCL 1.3.11

## Verification environments

* Ubuntu 16.04.1 LTS
* SBCL 1.3.16 64-bit
* clBLAS 2.10
* TITAN X (Pascal)
* OpenCL 1.2 CUDA 8.0.0
* NVIDIA Driver 378.13

## Author

* gos-k (mag4.elan@gmail.com)

## Copyright

Copyright (c) 2016-2017 gos-k (mag4.elan@gmail.com)

## License

Licensed under the Apache License, Version 2.0.
