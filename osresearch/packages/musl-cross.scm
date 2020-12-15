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

(define-module (osresearch packages musl-cross)
  #:use-module (gnu packages musl)
  #:use-module (gnu packages heads)
  #:use-module (gnu packages autotools)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system (not really?)
(define-public heads-musl-cross
  (package
    (inherit musl-cross)
    (name "heads-musl-cross")
    (version "0.1") ; FIXME
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/richfelker/musl-cross-make/archive/38e52db8358c043ae82b346a2e6e66bc86a53bc1.tar.gz"))
              (sha256
               (base32
                "0071ml3d42w8m59dc1zvl9pk931zcxsyflqacnwg5c6s7mnmvf5l"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `(("config.sub" ,automake)))
    (inputs
     `())
    (synopsis "musl-cross")
    (description "FIXME")
    (home-page "FIXME")
    (license #f)))
