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

(define-module (osresearch packages gcc)
  #:use-module (gnu packages gcc)
  #:use-module (guix packages)
  #:use-module (guix download))


;; TODO: Auto-target musl.
(define-public gcc-8.3
  (package
    (inherit gcc-7)
    (version "8.3.0")
    (source (origin
              (method url-fetch)
              (uri (string-append "mirror://gnu/gcc/gcc-"
                                  version "/gcc-" version ".tar.xz"))
              (sha256
               (base32
                "0b3xv411xhlnjmin2979nxcbnidgvzqdf4nbhix99x60dkzavfk4"))
              (patches (search-patches "gcc-8-strmov-store-file-names.patch"
                                       "gcc-5.0-libvtv-runpath.patch"))))))
