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

(define-module (osresearch packages util-linux)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system
(define-public heads-util-linux
  (package
    (inherit util-linux)
    (name "heads-util-linux")
    (version "2.29.2")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://www.kernel.org/pub/linux/utils/util-linux/v2.29/util-linux-"
                              version ".tar.xz"))
              (sha256
               (base32
                "1qz81w8vzrmy8xn9yx7ls4amkbgwx6vr62pl6kv9g7r0g3ba9kmc"))))
    (build-system gnu-build-system)
    (arguments
     (substitute-keyword-arguments (package-arguments util-linux)
       ((#:configure-flags _)
        '(list "--disable-bash-completion"
               "--disable-all-programs"
               "--enable-libuuid"
               "--enable-libblkid"))
       ((#:phases phases)
        `(modify-phases ,phases
           (replace 'pre-check
             (lambda* (#:key inputs outputs #:allow-other-keys)
               (with-fluids ((%default-port-encoding #f))
                      (let ((out (assoc-ref outputs "out"))
                            (net (assoc-ref inputs "net-base")))
                        ;; Change the test to refer to the right file.
                        (substitute* "tests/ts/misc/mcookie"
                          (("/etc/services")
                           (string-append net "/etc/services")))

                        ;; The C.UTF-8 locale does not exist in our libc.
                        (substitute* "tests/ts/column/invalid-multibyte"
                          (("C\\.UTF-8") "en_US.utf8"))

                        (substitute* "tests/expected/libmount/optstr-fix"
                          (("fixed:.*uid=0,gid=0")
                           "fixed:  uid=root,gid=root"))
                        #t))))))))
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `(("net-base" ,net-base)))))
