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

(define-module (osresearch packages dropbear)
  #:use-module (osresearch packages zlib)
  #:use-module (gnu packages ssh)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-dropbear
  (package
    (inherit dropbear)
    (name "heads-dropbear")
    (version "2016.74")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://matt.ucc.asn.au/dropbear/releases/dropbear-"
                              version ".tar.bz2"))
              (sha256
               (base32
                "14c8f4gzixf0j9fkx68jgl85q7b05852kk0vf09gi6h0xmafl817"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `(("heads-zlib" ,heads-zlib)))))
