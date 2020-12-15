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

(define-module (osresearch packages libksba)
  #:use-module (osresearch packages libgpg-error)
  #:use-module (gnu packages gnupg)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system ; FIXME: Set up gpg-error error prefix
(define-public heads-libksba
  (package
    (inherit libksba)
    (name "heads-libksba")
    (version "1.3.5")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://gnupg.org/ftp/gcrypt/libksba/libksba-"
                              version ".tar.bz2"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0h53q4sns1jz1pkmhcz5wp9qrfn9f5g9i3vjv6dafwzzlvblyi21"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `(("libgpg-error" ,heads-libgpg-error)))))
