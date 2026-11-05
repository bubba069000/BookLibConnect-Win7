# Book Lib Connect — Windows 7 download compatibility

A community-maintained Windows compatibility modification of [Book Lib Connect](https://github.com/audiamus/BookLibConnect) **version 0.14.1**.

> **Disclaimer:** This is unofficial software, provided as-is, without warranty, support, or a promise of future updates. It has received limited testing. Windows 7 compatibility is empirical; .NET 8 is not officially supported by Microsoft on Windows 7. The application and bundled components may contain known or undiscovered vulnerabilities. Use at your own risk (*caveat emptor*). Read the full [DISCLAIMER.txt](DISCLAIMER.txt) before using it.

## What this version changes

On affected Windows 7 systems, the original application's audiobook download HTTPS handshake fails when using Windows Schannel. This version replaces **only the audiobook file-download transport** with a bundled Windows x64 build of curl using LibreSSL.

The application is built from the original upstream 0.14.1 source. Audible login, library access, licence requests, decryption, and the user interface are not ported or rewritten. The exact upstream source commit is pinned in the build workflow, and the modified `AudibleApi.cs` source is provided in this repository under `patches/`.

The bundled curl archive is downloaded during the build and verified against a pinned SHA-256 digest. The build places `curl.exe` and its CA certificate bundle beside the application. The signed download URL is supplied to curl through standard input rather than placed on its command line.

## Upstream source and attribution

- Original project: https://github.com/audiamus/BookLibConnect
- Original release: 0.14.1
- Exact source baseline: `ed240bca2d475482b6fac61a201e39e827d8a46b`
- Original author: audiamus
- Original licence: GNU General Public License v3.0 (see [LICENSE](https://github.com/audiamus/BookLibConnect/blob/ed240bca2d475482b6fac61a201e39e827d8a46b/LICENSE))

This is an independent compatibility modification, not an official upstream release and not endorsed by the upstream author. The original upstream source is checked out at the pinned commit during every build. The modified source file and build scripts are included here so the build can be reproduced.

## Download

The intended public download is the **build 14** ZIP attached to the GitHub Release. See the [Releases page](https://github.com/bubba069000/BookLibConnect-Win7/releases). Do not use later Actions builds as substitutes for build 14 unless explicitly identified as a replacement release.

The package contains the application, `curl.exe`, `curl-ca-bundle.crt`, and a `BUILD.txt` identification file. The public release package should also contain `DISCLAIMER.txt`.

## Windows 7 compatibility

The original upstream project targets .NET 8. Microsoft does not officially support .NET 8 on Windows 7. This modification replaces the audiobook download TLS dependency that failed on the tested Windows 7 system; it does not claim official .NET 8 support for Windows 7. Compatibility is empirical and is not guaranteed for every Windows 7 configuration.

## Third-party components

The bundled curl distribution includes LibreSSL and its CA bundle. See [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md) for component and licence references.

## Responsible use

Use Book Lib Connect only with audiobooks from your own Audible account and in accordance with applicable law and Audible's terms. Do not redistribute downloaded audiobooks.
