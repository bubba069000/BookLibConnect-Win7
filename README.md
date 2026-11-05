# Book Lib Connect — Windows 7 download compatibility

This is a community-maintained modification of [Book Lib Connect](https://github.com/audiamus/BookLibConnect) version **0.14.1**.

## What changed

The original application uses .NET's HTTPS client for audiobook file downloads. On some Windows 7 systems, that download handshake fails because it relies on the operating system's Schannel TLS implementation.

This version changes **only the audiobook file-download transport**: it invokes a bundled Windows x64 build of curl using LibreSSL. Audible login, library access, licence requests, decryption, and the rest of the application remain based on the upstream 0.14.1 source.

The bundled curl distribution and its CA bundle are downloaded and SHA-256 verified during the GitHub Actions build. The curl URL is passed through standard input rather than exposed in the process command line.

## Source baseline and attribution

- Upstream project: https://github.com/audiamus/BookLibConnect
- Upstream version: 0.14.1
- Upstream source commit: `ed240bca2d475482b6fac61a201e39e827d8a46b`
- Upstream author: audiamus
- Original licence: GNU General Public License, version 3 (see [LICENSE](LICENSE))

This repository is an independent compatibility modification; it is not an official release of, or endorsed by, the upstream author. The upstream copyright notices and licence are retained. Changes in this repository are identified as modifications.

## Build

The GitHub Actions workflow in `.github/workflows/build-win7.yml` builds a self-contained Windows x64 application and packages the required curl executable and CA bundle alongside it.

A successful build does not by itself guarantee compatibility with every Windows 7 installation. The published build should be considered empirically tested on the systems identified in the release notes.

## Important

Use this application only with audiobooks from your own Audible account and in accordance with applicable law and Audible's terms. Do not distribute downloaded audiobooks.

