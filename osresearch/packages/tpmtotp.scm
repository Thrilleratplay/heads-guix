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

(define-module (osresearch packages tpmtotp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (osresearch packages mbedtls)
  #:use-module (osresearch packages qrencode)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-tpmtotp
  (package
    (name "heads-tpmtotp")
    (version "0.1") ; FIXME
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/osresearch/tpmtotp/archive/18b860fdcf5a55537c8395b891f2b2a5c24fc00a.tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0v30biwwqyqf06xnhmnwwjgb77m3476fvp8d4823x0xgwjqg50hh"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f                   ; No tests
       #:make-flags
       (list (string-append "CC=" ,(cc-for-target))
             (string-append "LDFLAGS=-Wl,-rpath=" (assoc-ref %outputs "out") "/lib"))
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (add-after 'unpack 'fix-installer
           (lambda* (#:key outputs #:allow-other-keys)
             (substitute* "Makefile"
              (("/usr") (assoc-ref outputs "out")))
             #t))
         (replace 'install
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (bin (string-append out "/bin"))
                    (lib (string-append out "/lib")))
               (install-file "totp" bin)
               (install-file "hotp" bin)
               (install-file "base32" bin)
               (install-file "qrenc" bin)
               (install-file "util/tpm" bin)
               (install-file "libtpm/libtpm.so" lib)
               #t))))))
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `(("heads-mbedtls" ,heads-mbedtls)
       ("heads-qrencode" ,heads-qrencode)))
    (synopsis "tpmtotp")
    (description "FIXME")
    (home-page "FIXME")
    (license #f)))
