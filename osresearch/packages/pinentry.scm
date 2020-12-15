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

(define-module (osresearch packages pinentry)
  #:use-module (osresearch packages libassuan)
  #:use-module (osresearch packages libgpg-error)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system; TODO: Use Guix pinentry?
(define-public heads-pinentry
  (package
    (name "heads-pinentry")
    (version "1.1.0")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-"
                              version ".tar.bz2"))
              (sha256
               (base32
                "0w35ypl960pczg5kp6km3dyr000m1hf0vpwwlh72jjkjza36c1v8"))))
    (build-system gnu-build-system)
    (arguments
     `(#:configure-flags
       '("--enable-pinentry-tty"
         "--disable-libsecret"
         "--disable-fallback-curses"
         "--disable-pinentry-curses"
         "--disable-pinentry-qt"
         "--disable-pinentry-gtk2"
         "--disable-pinentry-gnome3"
         "--disable-pinentry-fltk"
         "--disable-pinentry-emacs"
         "--disable-fallback-curses")))
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `(("heads-libgpg-error" ,heads-libgpg-error)
       ("heads-libassuan" ,heads-libassuan)))
    (synopsis "pinentry")
    (description "FIXME")
    (home-page "FIXME")
    (license #f)))
