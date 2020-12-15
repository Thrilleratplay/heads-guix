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


(define-module (osresearch packages boards x230)
  #:use-module (osresearch packages cairo)
  #:use-module (osresearch packages cryptsetup)
  #:use-module (osresearch packages dropbear)
  #:use-module (osresearch packages fbwhiptail)
  #:use-module (osresearch packages flashrom)
  #:use-module (osresearch packages flashtools)
  #:use-module (osresearch packages gpg)
  #:use-module (osresearch packages kexec)
  #:use-module (osresearch packages lvm2)
  #:use-module (osresearch packages mbedtls)
  #:use-module (osresearch packages pciutils)
  #:use-module (osresearch packages popt)
  #:use-module (osresearch packages qrencode)
  #:use-module (osresearch packages tpmtotp)
  #:use-module (osresearch packages util-linux)
  #:use-module (gnu packages linux)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu))

(define-public heads-boards-x230
  (let ((revision "0")
        (commit "671522eff43bbf87e3112ed0075f29fbf1a391fe"))
    (package
      (name "heads-boards-x230")
      (version (git-version "0.1" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/osresearch/heads.git")
                      (commit commit)))
                (file-name (string-append name "-" version "-checkout"))
                (sha256
                 (base32
                  "1m5yikx3l3s2khdnrbvqdb14khsync0hrkq35bv4h2ydhdmq6s9y"))))
      (build-system gnu-build-system)
      (inputs
       `(("heads-cryptsetup" ,heads-cryptsetup)
         ("heads-flashrom" ,heads-flashrom)
         ("heads-flashtools" ,heads-flashtools)
         ("heads-gpg2" ,heads-gpg2)
         ("heads-kexec" ,heads-kexec)
         ("heads-util-linux" ,heads-util-linux "lib")
         ("heads-lvm2" ,heads-lvm2)
         ("heads-mbedtls" ,heads-mbedtls)
         ("heads-pciutils" ,heads-pciutils)
         ("heads-popt" ,heads-popt)
         ("heads-qrencode" ,heads-qrencode)
         ("heads-tpmtotp" ,heads-tpmtotp)
         ("heads-dropbear" ,heads-dropbear)
         ("heads-cairo" ,heads-cairo)
         ("heads-fbwhiptail" ,heads-fbwhiptail)

         ; TODO CONFIG_LINUX_USBff
         ))
      (synopsis "heads-boards-x230")
      (description "This package provides a firmware image to flash to an
  X230.")
      (home-page "https://github.com/osresearch/heads/")
      (license license:gpl2))))
