#|
  This file is a part of cl-clblas project.
  Copyright (c) 2016 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-clblas-test
  (:use :cl
        :cl-clblas
        :prove
        :cffi
        :cl-oclapi))
(in-package :cl-clblas-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-clblas)' in your Lisp.

(plan nil)

(subtest "clblassetup"
  (is :clblassuccess (clblassetup) "can call setup"))

(subtest "clblassgemm"
  (is :clblassuccess (clblassetup))
  (is :clblasinvalidcommandqueue (clblassgemm :clblasrowmajor
                                              :clblasNoTrans
                                              :clblasNoTrans
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer)
                                              (null-pointer))))

(finalize)
