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

(define-module (osresearch packages hidapi)
  #:use-module (osresearch packages libusb)
  #:use-module (gnu packages libusb)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages pkg-config))

;; FIXME musl-build-system; FIXME move to librekey
(define-public heads-hidapi
  (package
    (inherit hidapi)
    (name "heads-hidapi")
    (version "0.1")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/Nitrokey/hidapi/archive/e5ae0d30a523c565595bdfba3d5f2e9e1faf0bd0.tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1q48449c8hvhj5acn4vyp9hcf8as0r399giy5df0h5w9k84abhmc"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `(("autoconf" ,autoconf)
       ("automake" ,automake)
       ("libtool" ,libtool)
       ("pkg-config" ,pkg-config)))
    (inputs
     `(("libudev" ,eudev)
       ("heads-libusb" ,heads-libusb)))))
