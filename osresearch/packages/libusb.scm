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

(define-module (osresearch packages libusb)
  #:use-module (gnu packages libusb)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages pkg-config))

;; FIXME musl-build-system
(define-public heads-libusb
  (package
    (inherit libusb)
    (name "heads-libusb")
    (version "1.0.21")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-" version "/libusb-" version ".tar.bz2"))
              (sha256
               (base32
                "0jw2n5kdnrqvp7zh792fd6mypzzfap6jp4gfcmq4n6c1kb79rkkx"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `())))


;; FIXME musl-build-system
(define-public heads-libusb-compat
  (package
    (inherit libusb-compat)
    (name "heads-libusb-compat")
    (version "0.1.5")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://downloads.sourceforge.net/project/libusb/libusb-compat-0.1/libusb-compat-"
                              version "/libusb-compat-" version ".tar.bz2"))
              (sha256
               (base32
                "0nn5icrfm9lkhzw1xjvaks9bq3w6mjg86ggv3fn7kgi4nfvg8kj0"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `(("pkg-config" ,pkg-config)))
    (inputs
`(("heads-libusb" ,heads-libusb)))))
