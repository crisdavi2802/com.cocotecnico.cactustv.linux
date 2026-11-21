# Manifiesto Flatpak de Cactus TV

Repo de manifiesto para construir `com.cocotecnico.cactustv.linux` usando
`org.electronjs.Electron2.BaseApp` 24.08. Es un porteo no oficial basado en
<https://cactus-tv-web.pages.dev/>.

## Archivos

- `com.cocotecnico.cactustv.linux.yml`: manifiesto.
- `com.cocotecnico.cactustv.linux.metainfo.xml`: metadatos AppStream.
- `com.cocotecnico.cactustv.linux.desktop`: entrada de escritorio.
- `generated-sources.json`: fuentes npm/Electron con checksums, generado con
  `flatpak-node-generator npm package-lock.json`.
- `build-local.sh`: atajo para construir e instalar el bundle localmente.

## Construir e instalar localmente

```bash
flatpak install -y flathub org.freedesktop.Platform//24.08 \
  org.freedesktop.Sdk//24.08 \
  org.freedesktop.Sdk.Extension.node22//24.08 \
  org.electronjs.Electron2.BaseApp//24.08

./build-local.sh
```

El resultado es `repo/com.cocotecnico.cactustv.linux.flatpak`. Para instalarlo:

```bash
flatpak install --user repo/com.cocotecnico.cactustv.linux.flatpak
flatpak run com.cocotecnico.cactustv.linux
```

## Como se construye

La fuente es el tarball del tag `v1.0.0-rc.1` del repo
[crisdavi2802/CactusTV-Linux-Nativo](https://github.com/crisdavi2802/CactusTV-Linux-Nativo).
Dentro del modulo se entra en `codigo/`, se instalan las dependencias desde el
cache offline y se ejecuta `electron-builder --linux --dir`. El directorio
`linux-unpacked` resultante se copia a `/app/main` y se lanza con
`zypak-wrapper.sh`.

`ffmpeg` se toma del runtime `org.freedesktop.Platform` 24.08 (incluye el
binario y las librerias AV), por lo que no se empaqueta una copia propia.

## Publicar en Flathub

1. Renombrar este repo a `com.cocotecnico.cactustv.linux` en GitHub.
2. Verificar el manifiesto con `flatpak-builder-lint`.
3. Abrir un PR en <https://github.com/flathub/flathub> siguiendo
   `start-submission.md` (appid, metainfo, build y revision).
4. Una vez aprobado, el repo se transfiere a la organizacion `flathub`.

## Aviso

No afiliado con Cactus TV ni con los emisores de los canales. El uso de los
enlaces y contenidos es responsabilidad de cada usuario.
