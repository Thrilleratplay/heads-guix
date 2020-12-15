;;; Copyright © 2020 Danny Milosavljevic <dannym@scratchpost.org>
;;;
;;; Heads is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 2 of the License, or (at
;;; your option) any later version.
;;;
;;; Heads is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with Heads.  If not, see <http://www.gnu.org/licenses/>.

(define-module (osresearch packages terminfo)
  #:use-module (guix packages))

(define-public heads-terminfo
  (package
    (inherit ncurses)
    (name "heads-terminfo")
    (arguments
     (substitute-keyword-arguments (package-arguments ncurses)
      ((#:tests? _ #f)
       #f)
      ((#:phases phases)
      `(modify-phases ,phases
         (delete 'post-install)
         (replace 'install
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (invoke "make" "install.data")))))))))
