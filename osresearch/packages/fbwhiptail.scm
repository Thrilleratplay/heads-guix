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

(define-module (osresearch packages fbwhiptail)
#:use-module (osresearch packages cairo)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix utils)
  #:use-module (gnu packages pkg-config))

;; FIXME musl-build-system
(define-public heads-fbwhiptail
  (package
    (name "heads-fbwhiptail")
    (version "0.1") ; FIXME
    (source (origin
              (method git-fetch)
              (uri (git-reference
                     (url "https://source.puri.sm/coreboot/fbwhiptail.git")
                     (commit "e5001e925d5ac791d4cb8fb4cf9d3fb97cde3e51")))
              (file-name (string-append name "-" version "-checkout"))
              (sha256
               (base32
                "1wlihcjyn801j4r3n872w3qpnc0pbg8n762xv9n8shvhsgarkc6k"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f            ; No tests
       #:make-flags
       (list (string-append "CC=" ,(cc-for-target))
             "fbwhiptail")
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (replace 'install
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((bin (string-append (assoc-ref outputs "out") "/bin")))
               (install-file "fbwhiptail" bin)
               #t))))))
    (propagated-inputs
     `())
    (native-inputs
     `(("pkg-config" ,pkg-config)))
    (inputs
     `(("heads-cairo" ,heads-cairo)))
    (synopsis "fbwhiptail")
    (description "FIXME")
    (home-page "FIXME")
    (license #f)))
