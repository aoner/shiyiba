const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = function(env) {
  const production = process.env.NODE_ENV === 'production';
  return {
    // 在webpack的配置文件中配置source maps
    devtool: production ? 'source-maps' : 'eval',
    optimization: {
      minimizer: [
        new UglifyJsPlugin({
          cache: true,
          parallel: true,
          sourceMap: false
        })
      ]
    },
    //已多次提及的唯一入口文件
    entry: {
      app: ['./js/app.js', './css/app.scss'],
      user: ['./js/app.js', './css/app.scss']
    },
    output: {
      filename: '[name].js',//打包后输出文件的文件名
      path: path.resolve(__dirname, '../priv/static/js') //打包后的文件存放的地方
    },
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: "babel-loader"
          }
        },
        {
          test: /\.s?[ac]ss$/,
          use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"]
        }
      ]
    },
    plugins: [
      new MiniCssExtractPlugin({
        filename: '../css/[name].css'
      }),
      new CopyWebpackPlugin([
        {
          from: 'static/',
          to: '../'
        }
      ])
    ],
    // extensions：自动解析确定的扩展,省去你引入组件时写后缀的麻烦，
    // alias：非常重要的一个配置，它可以配置一些短路径，
    // modules：webpack 解析模块时应该搜索的目录，
    resolve: {
      alias: {
        static: '${assets}/static'
      }
    }
  }
}