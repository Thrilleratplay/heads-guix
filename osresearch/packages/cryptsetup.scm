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

(define-module (osresearch packages cryptsetup)
  #:use-module (osresearch packages popt)
  #:use-module (osresearch packages lvm2)
  #:use-module (gnu packages cryptsetup)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-cryptsetup
  (package
    (inherit cryptsetup)
    (name "heads-cryptsetup")
    (version "1.7.3")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://www.kernel.org/pub/linux/utils/cryptsetup/v1.7/cryptsetup-"
                              version ".tar.xz"))
              (sha256
               (base32
                "00nwd96m9yq4k3cayc04i5y7iakkzana35zxky6hpx2w8zl08axg"))))
    (build-system gnu-build-system)
    (arguments
     `(#:configure-flags
       '("--disable-gcrypt-pbkdf2"
         "--enable-cryptsetup-reencrypt"
         "--with-crypto_backend=kernel")))
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `(("heads-popt" ,heads-popt)
       ("heads-lvm2" ,heads-lvm2)
       ("libuuid" ,heads-util-linux "lib")))))
