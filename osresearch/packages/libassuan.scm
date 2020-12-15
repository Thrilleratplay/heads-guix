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

(define-module (osresearch packages libassuan)
  #:use-module (osresearch packages libgpg-error)
  #:use-module (gnu packages gnupg)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-libassuan
  (package
    (inherit libassuan)
    (name "heads-libassuan")
    (version "2.5.3")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://gnupg.org/ftp/gcrypt/libassuan/libassuan-"
                              version ".tar.bz2"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "00p7cpvzf0q3qwcgg51r9d0vbab4qga2xi8wpk2fgd36710b1g4i"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `(("heads-libgpg-error" ,heads-libgpg-error)))))
