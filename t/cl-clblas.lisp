#|
  This file is a part of cl-clblas project.
  Copyright (c) 2016-2017 gos-k (mag4.elan@gmail.com)
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
  (is (clblas-setup)
      :+clblas-success+)

  (with-platform-id (platform)
    (with-device-ids (devices num-devices platform)
      (with-context (context (null-pointer) 1 devices)
        (let* ((device (mem-aref devices 'cl-device-id))
               (m 2)
               (n 2)
               (k 2)
               (a-elements (* m k))
               (b-elements (* k n))
               (c-elements (* m n))
               (float-size (foreign-type-size 'cl-float))
               (a-size (* float-size a-elements))
               (b-size (* float-size b-elements))
               (c-size (* float-size c-elements)))
          (with-buffers ((a-device context +cl-mem-read-only+ a-size)
                         (b-device context +cl-mem-read-only+ b-size)
                         (c-device context +cl-mem-write-only+ c-size))
            (with-foreign-objects ((a 'cl-float a-elements)
                                   (b 'cl-float b-elements)
                                   (c 'cl-float c-elements)
                                   (event 'cl-event))
              (loop for i below 4
                    do (setf (mem-aref a :float i)
                             (coerce i 'single-float)))
              (loop for i below 4
                    do (setf (mem-aref b :float i)
                             (coerce (* 2 i) 'single-float)))
              (loop for i below 4
                    do (setf (mem-aref c :float i)
                             (coerce (* 3 i) 'single-float)))

              (with-command-queue (command-queue context device 0)
                (labels ((write-buffer (device size host)
                           (enqueue-write-buffer command-queue
                                                 device
                                                 +cl-true+
                                                 0
                                                 size
                                                 host)))
                  (write-buffer a-device a-size a)
                  (write-buffer b-device b-size b)
                  (write-buffer c-device c-size c))
                (with-pointers ((cq command-queue))
                  (let ((err (clblas-sgemm :+clblas-row-major+
                                           :+clblas-no-trans+
                                           :+clblas-no-trans+
                                           (1- m)
                                           (1- n)
                                           (1- k)
                                           1.0
                                           a-device (1+ k) k
                                           b-device (1+ n) n
                                           2.0
                                           c-device (1+ n) n
                                           1
                                           cq
                                           0
                                           (null-pointer)
                                           event)))
                    (is err :+clblas-success+)
                    (finish command-queue)
                    (enqueue-read-buffer command-queue
                                         c-device
                                         +cl-true+
                                         0
                                         c-size
                                         c)
                    (is (mem-aref c :float 0) 0.0)
                    (is (mem-aref c :float 1) 3.0)
                    (is (mem-aref c :float 2) 6.0)
                    (is (mem-aref c :float 3) 36.0))))))))))
  (clblas-teardown))

(subtest "clblas-sgemv"
  (is (clblas-setup)
      :+clblas-success+)

  (with-platform-id (platform)
    (with-device-ids (devices num-devices platform)
      (with-context (context (null-pointer) 1 devices)
        (let* ((device (mem-aref devices 'cl-device-id))
               (m 2)
               (n 2)
               (a-elements (* m n))
               (x-elements m)
               (y-elements m)
               (float-size (foreign-type-size 'cl-float))
               (a-size (* float-size a-elements))
               (x-size (* float-size x-elements))
               (y-size (* float-size y-elements)))
          (with-buffers ((a-device context +cl-mem-read-only+ a-size)
                         (x-device context +cl-mem-read-only+ x-size)
                         (y-device context +cl-mem-write-only+ y-size))
            (with-foreign-objects ((a 'cl-float a-elements)
                                   (b 'cl-float x-elements)
                                   (c 'cl-float y-elements)
                                   (event 'cl-event))
              (loop for i below a-elements
                    do (setf (mem-aref a :float i)
                             (coerce i 'single-float)))
              (loop for i below x-elements
                    do (setf (mem-aref b :float i)
                             (coerce (* 2 i) 'single-float)))
              (loop for i below y-elements
                    do (setf (mem-aref c :float i)
                             (coerce (* 3 i) 'single-float)))

              (with-command-queue (command-queue context device 0)
                (labels ((write-buffer (device size host)
                           (enqueue-write-buffer command-queue
                                                 device
                                                 +cl-true+
                                                 0
                                                 size
                                                 host)))
                  (write-buffer a-device a-size a)
                  (write-buffer x-device x-size b)
                  (write-buffer y-device y-size c))
                (with-pointers ((cq command-queue))
                  (let ((err (clblas-sgemv :+clblas-row-major+
                                           :+clblas-no-trans+
                                           (1- m)
                                           (1- n)
                                           1.0
                                           a-device (1+ n) n
                                           x-device 0 1
                                           2.0
                                           y-device 0 1
                                           1
                                           cq
                                           0
                                           (null-pointer)
                                           event)))
                    (is err :+clblas-success+)
                    (finish command-queue)
                    (enqueue-read-buffer command-queue
                                         y-device
                                         +cl-true+
                                         0
                                         y-size
                                         c)
                    (is (mem-aref c :float 0) 0.0)
                    (is (mem-aref c :float 1) 3.0))))))))))
  (clblas-teardown))

(finalize)
