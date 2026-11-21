# Manifiesto Flatpak de Cactus TV (referencia local)

Repo de trabajo para construir `com.cocotecnico.cactustv.linux` contra
`org.electronjs.Electron2.BaseApp` 24.08. Es un porteo no oficial basado en
<https://cactus-tv-web.pages.dev/>.

> **No enviar este repo tal cual a Flathub.** Está validado solo como build
> local. Ver [Estado para Flathub](#estado-para-flathub).

## Archivos

- `com.cocotecnico.cactustv.linux.yml`: manifiesto.
- `com.cocotecnico.cactustv.linux.metainfo.xml`: metadatos AppStream.
- `com.cocotecnico.cactustv.linux.desktop`: entrada de escritorio.
- `generated-sources.json`: fuentes npm/Electron con checksums, generado con
  `flatpak-node-generator npm package-lock.json`.
- `build-local.sh`: atajo para construir e instalar el bundle localmente.
- `package.json`, `package-lock.json`: se conservan para poder regenerar
  `generated-sources.json`. No se usan durante el build.

## Construir e instalar localmente

```bash
flatpak install -y flathub org.freedesktop.Platform//24.08 \
  org.freedesktop.Sdk//24.08 \
  org.freedesktop.Sdk.Extension.node22//24.08 \
  org.electronjs.Electron2.BaseApp//24.08

./build-local.sh
```

El resultado es `repo/com.cocotecnico.cactustv.linux.flatpak`:

```bash
flatpak install --user repo/com.cocotecnico.cactustv.linux.flatpak
flatpak run com.cocotecnico.cactustv.linux
```

## Cómo se construye

La fuente es el tarball del tag `v1.0.0-rc.1` del repo
[crisdavi2802/CactusTV-Linux-Nativo](https://github.com/crisdavi2802/CactusTV-Linux-Nativo).
Dentro del módulo se entra en `codigo/`, se instalan las dependencias desde la
caché offline y se ejecuta `electron-builder --linux --dir`. El directorio
`release/linux-unpacked` resultante se copia a `/app/main` y se lanza con
`zypak-wrapper.sh`.

`ffmpeg` se toma del runtime `org.freedesktop.Platform` 24.08 (incluye el
binario y las librerías AV), por lo que no se empaqueta una copia propia.

Verificado con `flatpak-builder` 1.4.8: compila, el bundle se instala, el
sandbox expone `/app/main/resources/app.asar` y `/usr/bin/ffmpeg`, y
AppStream/desktop se exportan sin errores.

## Estado para Flathub

Este material fue generado/asistido con IA. La
[política de IA de Flathub](https://docs.flathub.org/docs/for-app-authors/requirements#generative-ai-policy)
prohíbe manifiestos generados o asistidos por IA —la divulgación no los
exime— y prohíbe que agentes de IA abran o automaticen PRs de envío, o que
generen sus mensajes de commit, descripciones o respuestas. Por eso el envío
debe hacerlo una persona y el manifiesto debe ser reescrito y revisado
manualmente antes de usarlo en una solicitud.

Además, antes de intentar el envío hay que resolver estos puntos de la
[lista de requisitos](https://docs.flathub.org/docs/for-app-authors/requirements):

- El ID `com.cocotecnico.cactustv.linux` termina en `.linux`, y los IDs no
  pueden terminar en términos genéricos (`.desktop`, `.app`, `.linux`).
- Los metadatos y el desktop deben estar integrados en el proyecto upstream,
  no copiados en el PR (salvo fuentes `extra-data`).
- Se exige localización completa en inglés de metainfo, desktop y docs.
- El runtime/base debe ser la versión más reciente al momento del envío
  (este manifiesto usa 24.08).
- Los wraps web que solo incrustan contenido remoto sin funcionalidad,
  pulido e integración de escritorio significativos no se aceptan.
- El nombre y el icono no deben violar marcas de terceros.
- Hay que publicar video de la app en Linux y acreditar relación con upstream.

Cuando una persona haya reescrito el manifiesto y corregido lo anterior, el
proceso vigente es abrir un PR contra la rama `new-pr` de
<https://github.com/flathub/flathub> (ya no existe `start-submission.md`),
usando la plantilla de PR, y pasar la revisión. Un agente de IA no debe
redactar ese PR ni intervenir en su revisión.

## Aviso

No afiliado con Cactus TV ni con los emisores de los canales. El uso de los
enlaces y contenidos es responsabilidad de cada usuario.
