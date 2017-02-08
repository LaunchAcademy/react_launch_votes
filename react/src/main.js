import 'babel-polyfill';
import 'whatwg-fetch';
import React from 'react'
import ReactDOM from 'react-dom'
import { createStore, combineReducers } from 'redux'
import { Provider } from 'react-redux'
import { Router, Route, browserHistory } from 'react-router'
import { syncHistoryWithStore, routerReducer } from 'react-router-redux'
import App from './components/App'

const store = createStore(
  combineReducers({
    routing: routerReducer
  })
)

const history = syncHistoryWithStore(browserHistory, store)

$(function() {
  let reactElement = document.getElementById('app');
  if (reactElement) {
    ReactDOM.render(
    <Provider store={store}>
      <Router history={history}>
        <Route path="/" component={App}>
        </Route>
      </Router>
    </Provider>,
    reactElement
    );
  };
});
