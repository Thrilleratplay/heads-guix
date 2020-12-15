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

(define-module (osresearch packages flashrom)
  #:use-module (osresearch packages libusb)
  #:use-module (osresearch packages pciutils)
  #:use-module (gnu packages flashing-tools)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (gnu packages pkg-config)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-flashrom
  (package
    (inherit flashrom)
    (name "heads-flashrom")
    (version "1.2")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://download.flashrom.org/releases/flashrom-v"
                              version ".tar.bz2"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ax4kqnh7kd3z120ypgp73qy1knz47l6qxsqzrfkd97mh5cdky71"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `(("pkg-config" ,pkg-config)))
    (inputs
     `(("heads-libusb" ,heads-libusb)
       ("heads-pciutils" ,heads-pciutils)))))
