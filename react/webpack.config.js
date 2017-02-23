const path = require("path");
const webpack = require("webpack");

module.exports = {
  entry: {
    script: path.resolve(__dirname, './src/main.js')
  },
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, '../app/assets/javascripts'),
    pathinfo: true
  },
   module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: 'babel-loader'
      }
    ]
  },
  devtool: 'eval-source-map'
};
