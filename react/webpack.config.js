var path = require('path');
var webpack = require("webpack");

module.exports = {
  entry: './react/src/main.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, '../app/assets/javascripts')
  },
   module: {
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      }
    ]
  },
  devtool: 'eval-source-map'
};
