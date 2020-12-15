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

(define-module (osresearch packages make)
  #:use-module (gnu packages base)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-make
  (package
    (inherit gnu-make)
    (name "heads-make")
    (version "4.2.1")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "http://gnu.mirror.constant.com/make/make-"
                              version ".tar.bz2"))
              (sha256
               (base32
                "12f5zzyq2w56g95nni65hc0g5p7154033y2f3qmjvd016szn5qnn"))))
    (build-system gnu-build-system)
    (arguments
     `(#:make-flags
       '("CFLAGS=-D__alloca=alloca")))
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `())))
