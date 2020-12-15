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

(define-module (osresearch packages busybox)
  #:use-module (osresearch packages gcc)
  #:use-module (gnu packages busybox)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module (gnu packages musl)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages base)
  #:use-module (guix build-system gnu))

(define (package-with-musl base)
  (package
    (inherit base)
    (arguments
     (substitute-keyword-arguments (package-arguments base)
      ((#:implicit-inputs? #f #f)
       #f)
      ((#:disallowed-references disallowed-references '())
       (cons glibc disallowed-references))
      ((#:phases phases)
       `(modify-phases ,phases
          (add-after 'unpack 'setenv-musl
            (lambda _
              #t))))))
    (native-inputs
     `(("musl" ,musl)
       ("tar" ,tar)
       ("make" ,gnu-make) ; TODO: gnu-make-final
       ("coreutils" ,coreutils) ; example user: heads-busybox package.
       ("xz" ,xz)
       ("gcc" ,gcc-8.3)
       ,@(package-native-inputs base)))))

;; FIXME musl-build-system
(define-public heads-busybox
  (package-with-musl (package
    (inherit busybox)
    (name "heads-busybox")
    (version "1.31.1")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://busybox.net/downloads/busybox-"
                                  version ".tar.bz2"))
              (sha256
               (base32
                "1659aabzp8w4hayr4z8kcpbk2z1q2wqhw7i1yb0l72b45ykl1yfh"))
              (patches
               (search-patches
                "busybox-1.31.1-fix-build-with-glibc-2.31.patch"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `(("inetutils" ,inetutils) ; for the tests
       ("which" ,which) ; for the tests
       ("zip" ,zip))) ; for the tests
    (inputs
     `()))))
