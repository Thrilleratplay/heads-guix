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

(define-module (osresearch packages popt)
  #:use-module (gnu packages popt)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-popt
  (package
    (inherit popt)
    (name "heads-popt")
    (version "1.16")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://launchpad.net/popt/head/"
                              version "/+download/popt-" version ".tar.gz"))
              (sha256
               (base32
                "1j2c61nn2n351nhj4d25mnf3vpiddcykq005w2h6kw79dwlysa77"))))
    (build-system gnu-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (add-before 'configure 'patch-test
           (lambda _
             (substitute* "test-poptrc.in"
               (("/bin/echo") (which "echo")))
             (substitute* "testit.sh"   ;don't expect old libtool names
               (("lt-test1") "test1"))
             #t)))))
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `())))
