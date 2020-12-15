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

(define-module (osresearch packages mbedtls)
  #:use-module (gnu packages tls)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system cmake)
  #:use-module (gnu packages perl)
  #:use-module (guix utils))

;; FIXME musl-build-system
(define-public heads-mbedtls
  (package
    (inherit mbedtls-apache)
    (name "heads-mbedtls")
    (version "2.4.2")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "https://tls.mbed.org/download/mbedtls-"
                              version "-gpl.tgz"))
              (sha256
               (base32
                "17r9qs585gqghcf5yavb1cnvsigl0f8r0k8rklr5a855hrajs7yh"))
              (patches
               (search-patches "mbedtls-2.4.2-fix-tests.patch"))))
    (build-system cmake-build-system)
    (arguments
     `( ;#:out-of-source? #t ; Make one of the tests find its data file
       #:configure-flags '("-DUSE_SHARED_MBEDTLS_LIBRARY=ON"
                           "-DUSE_STATIC_MBEDTLS_LIBRARY=OFF")
       #:make-flags
       (list (string-append "CC=" ,(cc-for-target))
             "SHARED=1"
             (string-append "LDFLAGS=-Wl,-rpath=" (assoc-ref %outputs "out") "/lib")
             (string-append "DESTDIR=" (assoc-ref %outputs "out")))
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (add-after 'unpack 'fix-tests
           (lambda _
             (write (getcwd))
             (newline)
             (setenv "CTEST_OUTPUT_ON_FAILURE" "1")
             (call-with-output-file "fake_time.c"
               (lambda (port)
                 (format port "#include <sys/time.h>

time_t time(time_t* p)
{
        time_t result = 1550065446;
        if (p)
                *p = result;
        return result;
}
")))
             (invoke ,(cc-for-target) "-fPIC" "-shared" "-o" "fake_time.so"
                     "fake_time.c")
             (substitute* "tests/Makefile"
              (("perl scripts/run-test-suites.pl")
               (string-append "LD_PRELOAD=" (getcwd) "/fake_time.so "
                              "perl scripts/run-test-suites.pl")))
             #t)))))
    (propagated-inputs
     `())
    (native-inputs
     `(("perl" ,perl)))
    (inputs
     `())))
