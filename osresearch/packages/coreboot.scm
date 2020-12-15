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


(define-module (osresearch packages coreboot)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages base)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages python)
  #:use-module (gnu packages compression)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (gnu packages cross-base)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-coreboot
  (package
    (name "heads-coreboot")
    (version "4.8.1")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://www.coreboot.org/releases/coreboot-"
                              version ".tar.xz"))
              (file-name (string-append name "-" version ".tar.xz"))
              (sha256
               (base32
                "08xdd5drk8yd37a3z5hc81qmgsybv6201i28hcggxh980vdz9pgh"))))
    (build-system gnu-build-system)
    (arguments
      `(#:make-flags
        ;; FIXME: Copy the other flags from Heads.
        (list "CROSS=i686-linux-gnu-"
              "DOTCONFIG=.config"
              "BUILD_TIMELESS=1"
              "CFLAGS_x86_32=-gno-record-gcc-switches -Wno-error=packed-not-aligned -Wno-error=packed-not-aligned"
              "CFLAGS_x86_64=-gno-record-gcc-switches -Wno-error=packed-not-aligned -Wno-error=packed-not-aligned"
              ;; TODO: Heads uses coreboot-built iasl instead.
              (string-append "IASL=" (assoc-ref %build-inputs "iasl")
                             "/bin/iasl"))
        #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'fix-build-failure
           (lambda _
             (substitute* "Makefile.inc"
              (("^spc :=") "null :=\nspc := $(null) $(null)"))))
         (replace 'configure
           (lambda* (#:key make-flags #:allow-other-keys)
             (call-with-output-file ".config"
               ;; FIXME: Get config from Heads.
               (lambda (port)
                (format port "CONFIG_ANY_TOOLCHAIN=y")))
             (apply invoke "make" "olddefconfig" make-flags))))))
    (propagated-inputs
     `())
    (native-inputs
      `(("cross-gcc" ,(cross-gcc "i686-linux-gnu"
                                 #:xbinutils (cross-binutils "i686-linux-gnu")
                                 #:libc (cross-libc "i686-linux-gnu")))
        ("cross-binutils" ,(cross-binutils "i686-linux-gnu"))
        ("iasl" ,acpica)
        ("flex" ,flex)
        ("perl" ,perl)
        ("python" ,python)
        ("python2" ,python-2)
        ("python3" ,python-3)))
    (inputs
     `())
    (synopsis "coreboot")
    (description "FIXME")
    (home-page "FIXME")
    (license license:gpl2)))

;; Note: This package's contents are installed to
;; $output/libexec/coreboot/3rdparty/blobs/ .
(define-public heads-coreboot-blobs
  (package
    (name "heads-coreboot-blobs")
    (version "4.8.1")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://www.coreboot.org/releases/coreboot-blobs-" version ".tar.xz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "15g222xj1zdn8i8qz0pw2jf28h66dljb1q5isw2ml05gwfd51ahq"))))
    (build-system copy-build-system)
    (arguments
     '(#:install-plan
       '(("." "libexec/coreboot/"))))
    (native-inputs
     `(("xz" ,xz)))
    (synopsis "Coreboot binary blobs")
    (description "This package provides the binary blobs needed for some
systems supported by coreboot.")
    (home-page "https://www.coreboot.org/")
    (license #f)))
