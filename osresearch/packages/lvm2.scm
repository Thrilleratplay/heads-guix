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

(define-module (osresearch packages lvm2)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages pkg-config))

;; FIXME musl-build-system
(define-public heads-lvm2
  (package
    (inherit lvm2)
    (name "heads-lvm2")
    (version "2.02.168")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://mirrors.kernel.org/sourceware/lvm2/LVM2."
                              version ".tgz"))
              (sha256
               (base32
                "03b62hcsj9z37ckd8c21wwpm07s9zblq7grfh58yzcs1vp6x38r3"))))
    (build-system gnu-build-system)
    (arguments
     (substitute-keyword-arguments (package-arguments lvm2)
      ((#:configure-flags _)
       '(list "PKG_CONFIG=false"
         "MODPROBE_CMD=false"
         "--enable-devmapper"
         "--disable-selinux"
         "--disable-udev-systemd-background-jobs"
         "--disable-realtime"
         "--disable-dmeventd"
         "--disable-lvmetad"
         "--disable-lvmpolld"
         "--disable-use-lvmlockd"
         "--disable-use-lvmetad"
         "--disable-use-lvmpolld"
         "--disable-blkid_wiping"
         "--disable-cmirrord"
         "--disable-cache_check_needs_check"
         "--disable-thin_check_needs_check"
         "--with-cluster=none"
         (string-append "LDFLAGS=-Wl,-rpath=" (assoc-ref %outputs "out") "/lib")))
      ((#:phases phases)
       `(modify-phases ,phases
          (add-after 'unpack 'setenv
            (lambda _
              (setenv "SHELL" "bash")
              ;; Disable config.
              (setenv "CONFDEST" "/tmp")
              #t))
          (replace 'install
            (lambda* (#:key outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (include (string-append out "/include"))
                     (bin (string-append out "/sbin"))
                     (lib (string-append out "/lib")))
                (install-file "include/libdevmapper-event.h" include)
                (install-file "include/libdevmapper.h" include)
                (install-file "include/lvm2cmd.h" include)
                (install-file "tools/dmsetup" bin)
                (install-file "tools/lvm" bin)
                (install-file "libdm/libdevmapper.so.1.02" lib)
                (install-file "libdm/libdevmapper.so" lib)
                #t)))))))
    (propagated-inputs
     `())
    (native-inputs
     `(("pkg-config" ,pkg-config)))
    (inputs
     `())))
