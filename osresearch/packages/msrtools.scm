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

(define-module (osresearch packages msrtools)
  #:use-module (gnu packages hardware)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages perl))

;; FIXME musl-build-system
(define-public heads-msrtools
  (package
    (inherit msr-tools)
    (name "heads-msrtools")
    (version "0.1") ; FIXME
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://github.com/osresearch/msr-tools/archive/572ef8a2b873eda15a322daa48861140a078b92c.tar.gz"))
              (sha256
               (base32
                "1h3a1rai47r0dxiiv0i3xj0fjng15n6sxj8mw9gj0154s284fmc0"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f    ; No tests
       #:make-flags
       (list (string-append "CC=" ,(cc-for-target)))
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (replace 'install
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((bin (string-append (assoc-ref outputs "out") "/bin")))
               (install-file "cpuid" bin)
               (install-file "rdmsr" bin)
               (install-file "wrmsr" bin)
               #t))))))
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `())))
