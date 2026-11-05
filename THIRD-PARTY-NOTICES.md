# Third-party notices

## curl and LibreSSL

The Windows curl package bundled in release builds is obtained from the official curl for Windows distribution:

- https://curl.se/windows/
- Archive: `curl-8.22.0_1-win64-mingw.zip`
- The build pins and verifies the archive SHA-256 before extracting it.
- The bundled curl build reports LibreSSL 4.3.2 as its TLS library.

curl is distributed under its curl licence (MIT-style). LibreSSL contains components under the OpenSSL, ISC, and other permissive licences. Their respective copyright and licence notices are available from the upstream projects:

- curl copyright and licence: https://curl.se/docs/copyright.html
- LibreSSL source and licence notices: https://github.com/libressl/portable

The Book Lib Connect application is licensed under GPL-3.0. Its complete original licence is retained in the upstream source repository at the exact commit identified in the README.
