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
var astppl = require('asset-pipeline');
astppl.set_app(app);
...

app.use(astppl.middleware())
```

In general that's all you need to use `asset-pipeline`. It will automatically route your assets to the `/assets` path
and compile all files on-the-fly. Also it will automatically detect the environment of your app and will use digested files
and prcompilation in the production mode.

# Configuring

Of course you can configure Asset Pipeline specifically to your app.

To do so you need run `#configure()` method on Asset Pipeline instance:

```javascript
astppl.configure({
	... your config here ...
});
```

## Options
| option                | descriprion                                                                                            |
| :-------------------: | :----------------------------------------------------------------------------------------------------- |
| `static_assets`       | path where your static assets live (default `/public/assets`)                                          |
| `assets_path`         | path where your assets will be available for the web (default `/assets`)                               |
| `assets_dir`          | paths where your assets live (default `['/app/assets', '/lib/assets', '/vendor/assets'])               |
| `auto_precompile_ext` | files with this extension will be precompiled automatically, e.g. 'app.prod.js' (default `['.prod']`)  |
| `precompile_files`    | list of files to be precompiled side by side with auto precompiled files (default `[]`)                |
| `precompile`          | switch files precompilation (default `true` for production and `false` for test and development)       |
