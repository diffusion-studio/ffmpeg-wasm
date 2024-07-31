# FFmpeg WASM DEMUXER
FFmpeg LGPL v2.1 build steps for generating a wasm module using emscripten.

### Steps to Reproduce
First execute `npm run dev:docker:arm64` to start a docker container with docker compose.

Next, execute `npm run build:wasm` to build the demuxer for the specified formats.
