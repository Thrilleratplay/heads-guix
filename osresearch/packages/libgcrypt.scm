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

(define-module (osresearch packages libgcrypt)
  #:use-module (osresearch packages libgpg-error)
  #:use-module (osresearch packages zlib)
  #:use-module (gnu packages gnupg)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages mcrypt))

;; FIXME musl-build-system
(define-public heads-libgcrypt
  (package
    (inherit libgcrypt)
    (name "heads-libgcrypt")
    (version "1.8.5")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-"
                              version ".tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0jgwhw6j7d5lrcyp4qviy986q7a6mj2zqi1hpjg0x646awk64vig"))))
    (build-system gnu-build-system)
    (arguments
     `(#:configure-flags
       '("--disable-static"
         "--disable-asm"
         "--disable-nls")))
    (propagated-inputs
     `())
    (native-inputs
     `(("bison" ,bison)
       ("flex" ,flex)
       ("pkg-config" ,pkg-config)))
    (inputs
     `(("libgpg-error-host" ,heads-libgpg-error) ; FIXME
       ("libmhash" ,libmhash) ; TODO: Or use libcrypt.
       ("heads-zlib" ,heads-zlib)))))
