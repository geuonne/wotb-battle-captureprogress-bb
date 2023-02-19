# WoT Blitz - Battle CaptureProgressBar BB

![Ally capturing](public/media/ally.jpg)
![Enemy capturing](public/media/enemy.jpg)
![Both trying to capture](public/media/both.jpg)

## Description
* [en](public/desc/en.txt)
* [ru](public/desc/ru.txt)

## Install
### Manual install
1. Download the `.zip` file from **Releases** section
2. Unpack chosen `.zip` file to `~res:/`

`~res:/` is the gamedata root:
- Android: `/your_sdcard/Android/data`
- Steam: `\Path\To\Steam\steamapps\common\World of Tanks Blitz`
- Windows Store: `...`

### Build from source

Dependencies
- [`dvpl` converter](https://github.com/Maddoxkkm/dvpl_converter)
- `make`
- `7z`
- `coreutils` (or any other POSIX-compliant util sets)

```sh
make [WMOD_TARGETPLATFORM=(android|pc|any)] [WMOD_TARGETPUBLISHER=(wg|lg|any)]
```

See [Makefile](Makefile) for details.

### Install
```sh
make [WMOD_PLATFORM=...] [WMOD_PUBLISHER=...] [WMOD_INSTALLDIR=<your_path_to_game>] install
```
### Deploy .zip package
```sh
make [WMOD_TARGETPLATFORM=...] [WMOD_PUBLISHER=...] package
```
