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

(define-module (osresearch packages cairo)
  #:use-module (osresearch packages libpng)
  #:use-module (osresearch packages pixman)
  #:use-module (gnu packages gtk)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages pkg-config))

;; FIXME musl-build-system
(define-public heads-cairo
  (package
    (inherit cairo)
    (name "heads-cairo")
    (version "1.14.12")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://www.cairographics.org/releases/cairo-"
                              version ".tar.xz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "05mzyxkvsfc1annjw2dja8vka01ampp9pp93lg09j8hba06g144c"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `(("heads-libpng" ,heads-libpng)
       ("heads-pixman" ,heads-pixman)))
    (native-inputs
     `(("pkg-config" ,pkg-config)))
    (inputs
     `())))
