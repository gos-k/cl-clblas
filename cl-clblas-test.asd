#|
  This file is a part of cl-clblas project.
  Copyright (c) 2016 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-clblas-test-asd
  (:use :cl :asdf))
(in-package :cl-clblas-test-asd)

(defsystem cl-clblas-test
  :author "gos-k"
  :license "Apache License, Version 2.0"
  :depends-on (:cl-clblas
               :prove
               :cl-oclapi)
  :components ((:module "t"
                :components
                ((:test-file "cl-clblas"))))
  :description "Test system for cl-clblas"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
