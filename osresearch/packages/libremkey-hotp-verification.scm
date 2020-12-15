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

(define-module (osresearch packages libremkey-hotp-verification)
  #:use-module (osresearch packages libusb)
  #:use-module (osresearch packages hidapi)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system cmake)
  #:use-module (gnu packages pkg-config))

;; FIXME musl-build-system; FIXME: Set up CONFIG_SHELL.
(define-public heads-libremkey-hotp-verification
  (package
    (name "heads-libremkey-hotp-verification")
    (version "0.1")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/Nitrokey/nitrokey-hotp-verification/archive/809953b9b4bef97a4cffaa20d675bd7fe9d8da53.tar.gz"))
              (file-name (string-append "nitrokey-hotp-verification-809953b9b4bef97a4cffaa20d675bd7fe9d8da53.tar.gz"))
              (sha256
               (base32
                "1fjqx6d5fc4h392v0b6k9ivxxl923vda3r29vknmxr74fkpmq7i5"))))
    (build-system cmake-build-system)
    (arguments
     `(#:tests? #f    ; No tests exist.
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'patch-include-paths
           (lambda* (#:key inputs #:allow-other-keys)
             (substitute* "CMakeLists.txt"
              (("/usr/include/libusb-1.0")
               (string-append (assoc-ref inputs "heads-libusb")
                              "/include/libusb-1.0"))
              (("include_directories[(]hidapi/hidapi[)]")
               "include_directories(hidapi)
include_directories(hidapi/hidapi)"))
             #t))
         (add-after 'unpack 'setenv
           (lambda* (#:key inputs #:allow-other-keys)
             (invoke "tar" "xf" (assoc-ref inputs "hidapi-source"))
             (rmdir "hidapi")
             (symlink "hidapi-e5ae0d30a523c565595bdfba3d5f2e9e1faf0bd0" "hidapi")
             #t)))))
    (propagated-inputs
     `())
    (native-inputs
     `(("hidapi-source" ,(package-source heads-hidapi))
       ("pkg-config" ,pkg-config))) ; useless
    (inputs
     `(("heads-libusb" ,heads-libusb)))
    ;; TODO: Unpack hidapi
    (synopsis "libremkey-hotp-verification")
    (description "FIXME")
    (home-page "FIXME")
    (license #f)))
