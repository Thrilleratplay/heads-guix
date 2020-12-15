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

(define-module (osresearch packages qrencode)
  #:use-module (gnu packages aidc)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (osresearch packages libpng)
  #:use-module (gnu packages pkg-config))

;; FIXME musl-build-system
(define-public heads-qrencode
  (package
    (inherit qrencode)
    (name "heads-qrencode")
    (version "3.4.4")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://fukuchi.org/works/qrencode/qrencode-"
                              version ".tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0wiagx7i8p9zal53smf5abrnh9lr31mv0p36wg017401jrmf5577"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `(("pkg-config" ,pkg-config)))
    (inputs
     `(("heads-libpng" ,heads-libpng)))))
