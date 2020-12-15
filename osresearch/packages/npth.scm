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

(define-module (osresearch packages npth)
  #:use-module (gnu packages gnupg)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-npth
  (package
    (inherit npth)
    (name "heads-npth")
    (version "1.6")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://gnupg.org/ftp/gcrypt/npth/npth-"
                              version ".tar.bz2"))
              (sha256
               (base32
                "1lg2lkdd3z1s3rpyf88786l243adrzyk9p4q8z9n41ygmpcsp4qk"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `())))
