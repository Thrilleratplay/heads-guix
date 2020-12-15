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

(define-module (osresearch packages libpng)
  #:use-module (osresearch packages zlib)
  #:use-module (gnu packages image)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-libpng
  (package
    (inherit libpng)
    (name "heads-libpng")
    (version "1.6.34")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://download.sourceforge.net/libpng/libpng-"
                              version ".tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "19v454hlpj98bqimrz8d2n3qlv026yadz8ml1846k68sj2j26ijp"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `(("heads-zlib" ,heads-zlib)))
    (native-inputs
     `())
    (inputs
     `())))
