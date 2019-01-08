# Sky

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

  {
  "scripts": {
    "deploy": "webpack --mode production",
    "start": "yarn run watch",
    "watch": "webpack --mode development --watch"
  },
  "devDependencies": {
    "babel-cli": "^6.26.0",
    "babel-core": "^6.26.3",
    "babel-loader": "^7.1.3",
    "babel-preset-es2015": "^6.24.1",
    "extract-text-webpack-plugin": "^3.0.2",
    "file-loader": "^1.1.11",
    "css-loader": "^0.28.10",
    "sass-loader": "^7.0.1",
    "node-sass": "^4.10.0",
    "style-loader": "^0.20.2",
    "webpack": "^4.26.0",
    "webpack-cli": "^3.1.2"
  },
  "dependencies": {
    "weui": "^1.1.3",
    "bootstrap": "^4.1.1",
    "font-awesome": "^4.7.0",
    "phoenix": "file:../deps/phoenix",
    "phoenix_html": "file:../deps/phoenix_html"
  }
}

