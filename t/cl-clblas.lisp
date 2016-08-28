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

(subtest "clblas-setup"
  (is :+clblas-success+ (clblas-setup) "can call setup"))

(subtest "clblas-sgemm"
  (is :+clblas-success+ (clblas-setup))
  (is :+clblas-invalid-command-queue+ (clblas-sgemm :+clblas-row-major+
                                                    :+clblas-no-trans+
                                                    :+clblas-no-trans+
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
