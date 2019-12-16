;;; global-readonly.el --- Auto toggle read only state  -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Free Software Foundation, Inc.

;; Author: owensys <owensys@hotmail.com>
;; URL: https://github.com/owensys/global-readonly
;; Version: 0.0.1
;; Keywords: lisp

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;;; Commentary:
;; 
;; Usage:
;; Add to load path, require global-readonly, then use global-readonly-toggle.
;; if you don't want disable all mouse key, set global-readonly-disable-mouse
;; to nil before require.
;;

;;; Code:
(defgroup global-readonly nil
  "Global readonly settings."
  :group 'global-readonly)

(defcustom global-readonly-disable-mouse t
  "If this value is t, disable all mouse event."
  :type 'boolean)

(defvar is-global-readonly nil)

(defun global-disable-mouse-key ()
  "Disable all mouse key"
  (dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]
	       [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
	       [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
	       [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
	       [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
    (global-unset-key k)))

(when global-readonly-disable-mouse
  (global-disable-mouse-key))

(defun global-auto-readonly ()
  (if (buffer-file-name)
      (if is-global-readonly
	  (read-only-mode 1)
	(read-only-mode 0)))) ;; Can't use nil, must use zero.

;;;###autoload
(defun global-readonly-toggle ()
  (interactive)
  (add-hook 'window-configuration-change-hook 'global-auto-readonly)
  (add-hook 'find-file-hook 'global-auto-readonly)
  (if is-global-readonly
      (progn
	(read-only-mode 0)
	(setq is-global-readonly nil)
	(message "global readonly disabled"))
    (progn
      (read-only-mode 1)
      (setq is-global-readonly t)
      (message "global readonly enabled"))))



(provide 'global-readonly-mode)
