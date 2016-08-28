#|
  This file is a part of cl-clblas project.
  Copyright (c) 2016 gos-k (mag4.elan@gmail.com)
|#

#|
  Author: gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-clblas-asd
  (:use :cl :asdf))
(in-package :cl-clblas-asd)

(defsystem cl-clblas
  :version "0.1"
  :author "gos-k"
  :license "Apache License, Version 2.0"
  :depends-on (:cffi)
  :components ((:module "src"
                :components
                ((:file "cl-clblas")
                 (:file "clblas-cffi"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op cl-clblas-test))))
