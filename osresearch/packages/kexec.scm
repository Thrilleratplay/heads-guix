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

(define-module (osresearch packages kexec)
  #:use-module (gnu packages linux)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-kexec
  (package
    (inherit kexec-tools)
    (name "heads-kexec")
    (version "2.0.20")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-"
                              version ".tar.gz"))
              (sha256
               (base32
                "05ksnlzal3sfnix9qds6qql1sjn3fxbdwgp3ncxxxjg032cdf5nb"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `())))
