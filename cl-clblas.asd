#|
  This file is a part of cl-clblas project.
  Copyright (c) 2016-2017 gos-k (mag4.elan@gmail.com)
|#

#|
  Author: gos-k (mag4.elan@gmail.com)
|#

(defsystem "cl-clblas"
  :version "0.1"
  :author "gos-k"
  :license "Apache License, Version 2.0"
  :depends-on ("cffi")
  :components ((:module "src"
                :components
                ((:file "cl-clblas")
                 (:file "clblas-cffi"))))
  :description "clBLAS binding"
  ;; :long-description #.(read-file-string (subpathname *load-pathname* #p"README.markdown"))
  :in-order-to ((test-op (test-op "cl-clblas-test"))))
