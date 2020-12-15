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

(define-module (osresearch packages linux)
  #:use-module (gnu packages linux)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages algebra))

;; FIXME musl-build-system
(define-public heads-linux
  (package
    (inherit linux-libre)
    (name "heads-linux")
    (version "FIXME")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://github.com/andikleen/linux-misc/archive/"
                "b87b58e1b057a2706d422fbdc76aa34309c6c90b.tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "122w48kx1fgq2xgq77hhnzhxmi8fwfwbryr4q4pamqa0896yvirh"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `())
    (native-inputs
     `(("perl" ,perl)
       ("bc" ,bc)
       ("openssl" ,openssl)
       ("elfutils" ,elfutils)  ; Needed to enable CONFIG_STACK_VALIDATION
       ("flex" ,flex)
       ("bison" ,bison)

       ;; These are needed to compile the GCC plugins.
       ("gmp" ,gmp)
       ("mpfr" ,mpfr)
       ("mpc" ,mpc)))
    (inputs
     `())))
