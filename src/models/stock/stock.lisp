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
(defpackage quaremain.models.stock.stock
  (:documentation "Stock super class.")
  (:use :cl))
(in-package :quaremain.models.stock.stock)

(defclass <stock> ()
  ((id
    :accessor id
    :initarg :id
    :initform nil
    :type integer)
   
   (name
    :accessor name
    :initarg :name
    :initform nil
    :type string)
   
   (description
    :accessor description
    :initarg :name
    :initform nil
    :type string)

   (amount
    :accessor amount
    :initarg :amount
    :initform nil
    :type integer)

   (cost-per-package
    :accessor cost-per-package
    :initarg :amount
    :initform nil
    :type single-float)))