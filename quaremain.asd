(defsystem "quaremain"
  :version ""
  :author "Momozor"
  :license "GPL-3.0-or-later"
  :depends-on ("clack"
               "lack"
               "caveman2"
               "cl-ppcre"
               "uiop"

               ;; HTML template rendering.
               "djula"

               ;; For database.
               "sxql"
               "datafly"
               "dbd-sqlite3"

               ;; Logging.
               "log4cl"

               ;; Deploying
               "lack-middleware-static"
               "lack-middleware-session"
               "hunchentoot"
               "clack-handler-hunchentoot"
               ;; "cl-webkit2" if bundling webkit2 and gtk stuff are needed
               )
  :components ((:module "src/utilities"
                        :components
                        ((:file "string")
                         (:file "config")
                         (:file "database" :depends-on ("config"))
                         (:file "exception")))
               
               (:module "src"
                        :depends-on ("src/models/stock" "src/utilities")
                        :components
                        ((:file "main" :depends-on ("view"
                                                    "web"))
                         (:file "web" :depends-on ("view"))
                         (:file "view")))
               
               (:module "src/models/stock"
                        :depends-on ("src/utilities")
                        :components
                        ((:file "stock"))))
  :description "Manage your basic survival resources like food and water
for preparation of emergency times"
  

  :defsystem-depends-on (:deploy)
  :build-operation "deploy-op"
  :build-pathname "quaremain"
  :entry-point "quaremain:main"
  :in-order-to ((test-op (test-op "quaremain/tests"))))

(defsystem "quaremain/tests"
    :author "Momozor"
    :license "GPL-3.0-or-later"
    :depends-on ("quaremain"
                 "rove")
    :components ((:module "tests"
                          :components
                          ((:file "main"))))
    :description "Test system for quaremain"
    :perform (test-op (op c) (symbol-call :rove :run c)))
