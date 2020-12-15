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

(define-module (osresearch packages pixman)
  #:use-module (gnu packages xdisorg)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-pixman
  (package
    (inherit pixman)
    (name "heads-pixman")
    (version "0.34.0")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://www.cairographics.org/releases/pixman-"
                              version ".tar.gz"))
              (sha256
               (base32
                "13m842m9ffac3m9r0b4lvwjhwzg3w4353djkjpf00s0wnm4v5di1"))))
    (build-system gnu-build-system)
    (arguments
     `(#:configure-flags
       '("--disable-gtk")))
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `())))
