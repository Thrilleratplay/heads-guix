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

(define-module (osresearch packages slang)
  #:use-module (osresearch packages terminfo)
  #:use-module (gnu packages slang)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu))

;; FIXME musl-build-system; FIXME i386-elf-linux.
(define-public heads-slang
  (package
    (inherit slang)
    (name "heads-slang")
    (version "2.3.1a")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://www.jedsoft.org/releases/slang/slang-" version ".tar.bz2"))
              (sha256
               (base32
                "0dlcy0hn0j6cj9qj5x6hpb0axifnvzzmv5jqq0wq14fygw0c7w2l"))))
    (build-system gnu-build-system)
    (arguments
     `(#:parallel-tests? #f
       #:parallel-build? #f  ; there's at least one race
       #:configure-flags
       '("--with-z=no"
         "--with-png=no"
         "--with-pcre=no"
         "--with-onig=no")
       #:phases
       (modify-phases %standard-phases
         (add-before 'configure 'substitute-before-config
           (lambda* (#:key inputs #:allow-other-keys)
             (let ((ncurses (assoc-ref inputs "ncurses")))
               (substitute* "configure"
                 (("MISC_TERMINFO_DIRS=\"\"")
                  (string-append "MISC_TERMINFO_DIRS="
                                 "\"" ncurses "/share/terminfo" "\"")))
               #t)))
         (add-after 'unpack 'fix-references
           (lambda _
             (substitute* "src/Makefile.in"
              (("/bin/ln") "ln"))
             #t)))))
    (propagated-inputs
     `())
    (native-inputs
     `())
    (inputs
     `(("ncurses" ,heads-terminfo)))))
