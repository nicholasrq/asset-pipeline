# Asset Pipeline (WIP) for NodeJS

[![Build Status](https://travis-ci.org/nicholasrq/asset-pipeline.png?branch=master)](https://travis-ci.org/nicholasrq/asset-pipeline)

Asset pipeline is a NodeJS module designed specially for Express.js.

It works like Rails asset pipeline and provides special helpers to include JS and CSS into your page.

To start just install Asset Pipeline using `npm`:

```shell
npm install assets-pipeline
```

Then you need to configure your app to use the module:

```javascript
...
astppl = require('asset-pipeline');
...

app.use(astppl.middleware())
```

In general that's all you need to use `asset-pipeline`. It will automatically route your assets to the `/assets` path
and compile all files on-the-fly. Also it will automatically detect the environment of your app and will use digested files
and prcompilation in the production mode.
