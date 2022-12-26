(defpackage #:bootstrap
  (:use :common-lisp))

(in-package #:bootstrap)

(ql:quickload :clack)
(ql:quickload :ningle)

(defvar app (make-instance 'ningle:app))

(setf (ningle:route app "/") "Hello, from CL!")

(setf (ningle:route app "/:limit" :method :get)
  #'(lambda (params)
      (let ((limit (cdr (assoc :limit params))))
        (handler-case
            (format nil "~a" (random (parse-integer limit)))
          (error ()
            (format nil "Invalid input: ~a" limit))))))

(clack:clackup app :port 8080)

(clack:stop app)