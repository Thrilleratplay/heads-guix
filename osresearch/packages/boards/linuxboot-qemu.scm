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

(define-module (osresearch packages boards linuxboot-qemu)
  #:use-module (osresearch packages linux)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages file)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages assembly)
  #:use-module (gnu packages python)
  #:use-module (guix utils))

(define udk2018
  (origin
    (method git-fetch)
    (uri
     (git-reference
       (url "https://github.com/linuxboot/edk2")
       (commit "UDK2018"))) ; branch
     (file-name "edk2")
     (sha256
      (base32 "0s3vljxhbsbdjy2a2ydv0835rhdakvhn8c8p4x4ch29fcrjc3ymf"))))

;; FIXME musl-build-system
  (define (heads-linuxboot board)
  (package
  (name (string-append "heads-linuxboot-" board))
  (version "FIXME")
  (source (origin
            (method git-fetch)
            (uri
             (git-reference
               (url "https://github.com/osresearch/linuxboot")
               (commit "b5376a441e8e85cbf722e943bb8294958e87c784")))
            (file-name (string-append name "-" version "-checkout"))
            (sha256
             (base32
              "1bdj4m9dvih9fhp5q5c6cp5sphzbpag5gp4bz1p8g9lqi49lb7av"))))
  (build-system gnu-build-system)
  (arguments
   `(#:make-flags
     (list "SHELL=bash"
           (string-append "CC=" ,(cc-for-target))
           "BUILD_CC=gcc"
           (string-append "KERNEL=" (assoc-ref %build-inputs "heads-linux") "/bzImage")
           (string-append "INITRD=initrd.cpio.xz")
           (string-append "BOARD=" ,board))
     #:phases
     (modify-phases %standard-phases
       (replace 'configure
         (lambda _
           (setenv "SHELL" "bash")
           #t))
       (add-after 'unpack 'unpack-edk2
         (lambda* (#:key inputs #:allow-other-keys)
           (copy-recursively (assoc-ref inputs "edk2") "edk2")
           ;; Delete broken link.
           (chmod "edk2/EmulatorPkg/Unix/Host" #o770)
           (delete-file "edk2/EmulatorPkg/Unix/Host/X11IncludeHack")
           ;; The git checkout must be writable for tests.
           (for-each make-file-writable (find-files "edk2"))
           ;; Guix reproducibility had .git deleted, but the Makefile expects it as a (fake) dependency.
           (call-with-output-file "edk2/.git"
             (const #t))
           #t))
       (add-after 'unpack-edk2 'build-edk2
         (lambda* (#:key make-flags #:allow-other-keys)
           (apply invoke "make" "edk2.force" make-flags)
           (when (string=? ,board "qemu")
             (with-directory-excursion "edk2/OvmfPkg"
               (invoke "./build.sh" "-n" (number->string (parallel-job-count)))))))
       (add-after 'unpack 'patch-references
         (lambda _
           (substitute* "dxe/Makefile"
            (("/usr/bin/printf") "command printf"))
           #t))
       (add-after 'unpack 'prepare-initrd
         (lambda* (#:key inputs #:allow-other-keys)
           (copy-file (string-append (assoc-ref inputs "heads-dev-cpio") "/libexec/dev.cpio")
                      "initrd.cpio")
           ;; FIXME: Make sure that initrd.cpio.xz is a multiple of 512 Byte long! (see Heads)
           (invoke "xz" "-f" "--check=crc32" "--lzma2=dict=1MiB" "-9"
                   "initrd.cpio")
           #t)))))
  (propagated-inputs
   `())
  (native-inputs
   `(("acpica" ,acpica)
     ("brotli" ,google-brotli)
     ("edk2" ,udk2018)
     ("file" ,file)
     ("libuuid" ,util-linux "lib")
     ("nasm" ,nasm)
     ("perl" ,perl)
     ("python" ,python-2)
     ("xz" ,xz)))
  (inputs
   `(
   ; ("heads-dev-cpio" ,heads-dev-cpio)
     ("heads-linux" ,heads-linux)))
  (synopsis "linuxboot")
  (description "FIXME")
  (home-page "FIXME")
  (license #f)))

(define-public linuxboot-qemu
  (heads-linuxboot "qemu"))
