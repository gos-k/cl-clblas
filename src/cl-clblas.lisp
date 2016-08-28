#|
  This file is a part of cl-clblas project.
  Copyright (c) 2016 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-clblas
  (:use :cl
        :cffi))
(in-package :cl-clblas)

(eval-when (:load-toplevel)
  (define-foreign-library libclblas
    (t (:default "libclBLAS")))

  (unless (foreign-library-loaded-p 'libclblas)
    (use-foreign-library libclblas)))
