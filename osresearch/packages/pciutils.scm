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

(define-module (osresearch packages pciutils)
  #:use-module (gnu packages pciutils)
  #:use-module (osresearch packages zlib)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-pciutils
  (package
    (inherit pciutils)
    (name "heads-pciutils")
    (version "3.5.4")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://www.kernel.org/pub/software/utils/pciutils/pciutils-" version ".tar.xz"))
              (sha256
               (base32
                "0rpy7kkb2y89wmbcbfjjjxsk2x89v5xxhxib4vpl131ip5m3qab4"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `(("heads-zlib" ,heads-zlib)))))
