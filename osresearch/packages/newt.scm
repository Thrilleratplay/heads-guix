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

(define-module (osresearch packages newt)
  #:use-module (osresearch packages slang)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-newt
  (package
    (name "heads-newt")
    (version "0.52.20")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://releases.pagure.org/newt/newt-" version ".tar.gz"))
              (sha256
               (base32
                "1g3dpfnvaw7vljbr7nzq1rl88d6r8cmrvvng9inphgzwxxmvlrld"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f               ; No tests
       #:make-flags
       `("INSTALL=install"
         ,(string-append "LDFLAGS=-Wl,-rpath=" (assoc-ref %outputs "out") "/lib"))))
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `(("heads-slang" ,heads-slang)
       ("heads-popt" ,heads-popt)))
    (synopsis "newt")
    (description "FIXME")
    (home-page "FIXME")
    (license #f)))
