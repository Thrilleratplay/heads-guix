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

(define-module (osresearch packages gpg)
  #:use-module (osresearch packages libgcrypt)
  #:use-module (osresearch packages libksba)
  #:use-module (osresearch packages libassuan)
  #:use-module (osresearch packages npth)
  #:use-module (osresearch packages zlib)
  #:use-module (osresearch packages libgpg-error)
  #:use-module (gnu packages gnupg)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages security-token)
  #:use-module (gnu packages pkg-config))

;; FIXME musl-build-system
(define-public heads-gpg
  (package
    (inherit gnupg-1)
    (name "heads-gpg")
    (version "1.4.21")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-"
                              version ".tar.bz2"))
              (sha256
               (base32
                "0xi2mshq8f6zbarb5f61c9w2qzwrdbjm4q8fqsrwlzc51h8a6ivb"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `())))

;; FIXME musl-build-system
(define-public heads-gpg2
  (package
    (inherit gnupg)
    (name "heads-gpg2")
    (version "2.2.20")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-"
                              version ".tar.bz2"))
              (sha256
               (base32
                "0c6a4v9p6qzhsw1pfcwc459bxpc8hma0w9z8iqb9khvligack9q4"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `(("pkg-config" ,pkg-config))) ; TODO: Remove?
    (inputs
     `(("heads-libgpg-error" ,heads-libgpg-error)
       ("heads-libgcrypt" ,heads-libgcrypt)
       ("heads-libassuan" ,heads-libassuan)
       ("heads-libksba" ,heads-libksba)
       ("heads-npth" ,heads-npth)
       ("heads-zlib" ,heads-zlib) ; TODO: Check.
       ("pcsc-lite" ,pcsc-lite)))))
