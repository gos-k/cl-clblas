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
  (is (clblas-setup)
      :+clblas-success+)
  (is (clblas-sgemm :+clblas-row-major+
                    :+clblas-no-trans+
                    :+clblas-no-trans+
                    0
                    0
                    0
                    0.0
                    (null-pointer) 0 0
                    (null-pointer) 0 0
                    0.0
                    (null-pointer) 0 0
                    0
                    (null-pointer)
                    0
                    (null-pointer)
                    (null-pointer))
      :+clblas-invalid-command-queue+)

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
                                   (c 'cl-float c-elements))
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
                (with-foreign-objects ((m-1 'cl-size)
                                       (n-1 'cl-size)
                                       (k-1 'cl-size)
                                       (alpha 'cl-float)
                                       (off-a 'cl-size)
                                       (lda 'cl-size)
                                       (off-b 'cl-size)
                                       (ldb 'cl-size)
                                       (beta 'cl-float)
                                       (off-c 'cl-size)
                                       (ldc 'cl-size)
                                       (num-command-queue 'cl-uint)
                                       (num-events-in-wait-list 'cl-uint))

                  (setf (mem-aref m-1 'cl-size) (1- m)
                        (mem-aref n-1 'cl-size) (1- n)
                        (mem-aref k-1 'cl-size) (1- k)
                        (mem-aref alpha 'cl-float) 1.0
                        (mem-aref off-a 'cl-size) (1+ m)
                        (mem-aref lda 'cl-size) k
                        (mem-aref off-b 'cl-size) (1+ n)
                        (mem-aref ldb 'cl-size) n
                        (mem-aref beta 'cl-float) 2.0
                        (mem-aref off-c 'cl-size) (1+ n)
                        (mem-aref ldc 'cl-size) n
                        (mem-aref num-command-queue 'cl-uint) 1
                        (mem-aref num-events-in-wait-list 'cl-uint) 0)
                  (with-pointers ((a-pointer a-device)
                                  (b-pointer b-device)
                                  (c-pointer c-device)
                                  (cq command-queue))
                    (let ((err (clblas-sgemm :+clblas-row-major+
                                             :+clblas-no-trans+
                                             :+clblas-no-trans+
                                             m-1
                                             n-1
                                             k-1
                                             alpha
                                             a-pointer off-a lda
                                             b-pointer off-b ldb
                                             beta
                                             c-pointer off-c ldc
                                             num-command-queue
                                             ;cq
                                             command-queue
                                             num-events-in-wait-list
                                             (null-pointer)
                                             (null-pointer))))
                      (is err :+clblas-success+)
                      (when (eql err :+clblas-success+)
                        (finish command-queue)
                        (enqueue-read-buffer command-queue
                                             c-device
                                             +cl-true+
                                             0
                                             c-size
                                             c)
                        (print-foreign-array c c-elements 'cl-float))))))))))))
  (clblas-teardown))

(finalize)
