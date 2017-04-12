#|
  This file is a part of cl-clblas project.
  Copyright (c) 2016-2017 gos-k (mag4.elan@gmail.com)
|#

(defsystem "cl-clblas-test"
  :author "gos-k"
  :license "Apache License, Version 2.0"
  :depends-on ("cl-clblas"
               "prove"
               "cffi"
               "cl-oclapi")
  :components ((:module "t"
                :components
                ((:test-file "cl-clblas"))))
  :description "Test system for cl-clblas"

  :defsystem-depends-on ("prove-asdf")
  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
