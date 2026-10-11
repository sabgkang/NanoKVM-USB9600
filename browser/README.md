# NanoKVM-USB Browser

The browser client is a standalone HTML application. It has no package
dependencies and does not require a build step.

## Run locally

Serve this directory from localhost:

```shell
cd browser
python3 -m http.server 8080
```

Open `http://localhost:8080` in desktop Chrome or Chromium.

Do not open `index.html` directly with a `file://` URL. Camera, microphone,
clipboard, File System Access, and Web Serial APIs require a secure context;
`localhost` is treated as secure by supported browsers.

## Deploy with Docker

From the repository root:

```shell
docker compose up -d --build
```

Then open `http://localhost:9000`.

Web Serial is currently supported by desktop Chromium-based browsers. Browsers
without Web Serial can display video but cannot forward keyboard or mouse input.
