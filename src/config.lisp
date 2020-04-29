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
(defpackage quaremain.config
  (:documentation "All system-wide configurations goes here.")
  (:use :cl)
  (:export :+static-directory+
           :+template-directory+
           :+database-path+))
(in-package :quaremain.config)

(defparameter +static-directory+
  (pathname "static/")
  "Anything that need to be served directly without going through server-side
   rendering goes here. Examples, Javascript, CSS and images.")

(defparameter +template-directory+
  (pathname "templates/")
  "Server-side HTML templates goes here. Obviously, HTML.")

(defparameter +database-path+ "var/quaremain.db"
  "Primary SQLite3 database location path.")
