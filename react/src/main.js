import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';

$(function() {
  ReactDOM.render(
    <h1>Hello from <code>main.js</code></h1>,
    document.getElementById('app')
  );
});
