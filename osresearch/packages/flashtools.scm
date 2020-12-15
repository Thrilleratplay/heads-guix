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

(define-module (osresearch packages flashtools)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix utils))

;; FIXME musl-build-system
(define-public heads-flashtools
  (package
    (name "heads-flashtools")
    (version "0.0.1") ; FIXME
    (source (origin
              (method git-fetch)
              (uri
               (git-reference
                 (url "https://github.com/osresearch/flashtools")
                 (commit "9acce09aeb635c5bef01843e495b95e75e8da135")))
              (file-name (string-append "flashtools-" version ".tar.gz"))
              (sha256
               (base32
                "0r4gj3nzr67ycd39k1vjzxfzkp90yacrdgxhc1z5jfvxfq4x91c1"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f       ; No tests
       #:make-flags
       (list (string-append "CC=" ,(cc-for-target)))
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (replace 'install
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((bin (string-append (assoc-ref outputs "out") "/bin")))
               (install-file "flashtool" bin)
               (install-file "peek" bin)
               (install-file "poke" bin)
               (install-file "cbfs" bin)
               (install-file "uefi" bin)
               #t))))))
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `())
    (synopsis "flashtools")
    (description "FIXME")
    (home-page "FIXME")
    (license #f)))
