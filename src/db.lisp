;;;; Quaremain - A software to manage resources for emergency times.
;;;; Copyright (C) 2020  Momozor <skelic3@gmail.com, momozor4@gmail.com>

;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation, either version 3 of the License, or
;;;; (at your option) any later version.

;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.

;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(in-package :cl-user)
(defpackage quaremain.db
  (:documentation "Database access handler")
  (:use :cl)
  (:import-from :cl-dbi
                :connect-cached
                :disconnect)
  (:import-from :datafly
                :execute
                :*connection*)
  (:import-from :sxql
                :create-table
                :drop-table)
  (:import-from :quaremain.config
                :+database-path+)

  ;; Exceptions.
  (:import-from :sqlite
                :sqlite-error)
  (:import-from :dbi.error
                :dbi-programming-error)
  (:export :db
           :with-connection
           :with-connection-execute
           :migrate-models
           :drop-models))
(in-package :quaremain.db)

(defun db ()
  "Database init connection.

   returns: database connection instance"
  (connect-cached
   :sqlite3
   :database-name +database-path+))

(defmacro with-connection (connection &body body)
  "Wraps connection call to the database.

   connection -> connection instance
   body -> SXQL forms

   returns: nil"
  `(let ((*connection* ,connection))
     (unwind-protect (progn ,@body)
       (disconnect *connection*))))

(defmacro with-connection-execute (&body body)
  "Database connection wrapper which executes SXQL forms
   on call.

   body -> SXQL forms

   returns: nil
   "
  `(with-connection (db)
     (execute ,@body)))


(defmacro deftable (table-name &body extra-column-specifier)
  "Define a basic base table for new model.

   table-name -> keyword
   extra-column-specifier -> SXQL column specifier
   
   returns: generated & translated SXQL forms

   Example: (deftable :user (:username :type 'varchar) (:password :type 'text))
   "
  `(let ((schema
          (create-table (,table-name :if-not-exists t)
              ((id :type 'integer :primary-key t)
               (name :type 'text :not-null t)
               (description :type 'text :not-null t)
               (amount :type 'integer :not-null t)
               (cost-per-package :type 'real :not-null t)
               ,@extra-column-specifier))))
     schema))

(defun migrate-models ()
  "Migrate all models schemas into the database.

   returns: nil"
  (handler-case
      (progn
        (log:info "Attempting to migrate all models schemas if not exist.")
        (with-connection (db)
          (mapcar (lambda (model)
                    (execute model))
                  (list (deftable :food
                          (calories-per-package
                           :type 'integer
                           :not-null t))
                        (deftable :water)
                        (deftable :medicine)
                        (deftable :weapon)))))
    (sqlite-error (exception)
      (log:error "Are you trying to run from the outside of
                  Quaremain's project directory?")
      (log:error "[SQLITE-ERROR]: ~A" exception)
      (uiop:quit 1))))

(defun drop-models ()
  "Erase all existing models tables from the database.

   returns: nil"
  (handler-case
      (progn
        (log:info "Attempting to erase all models tables from the database")
        (with-connection (db)
          (mapcar (lambda (table)
                    (execute
                     (drop-table table)))
                  (list :food
                        :water
                        :medicine
                        :weapon)))
        (log:info "Database models tables has been erased"))
    (dbi-programming-error (exception)
      (log:error "[DBI-PROGRAMMING-ERROR]: ~A" exception)
      (log:error "No existing tables in the database found to be erased"))
    (sqlite-error  (exception)
      (log:error "[SQLITE-ERROR]: ~A" exception)
      (log:error "Are you trying to run from the outside of
                  Quaremain's project directory?")
      (uiop:quit 1))))
