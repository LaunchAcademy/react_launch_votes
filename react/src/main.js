import 'babel-polyfill';
import 'whatwg-fetch';
import React from 'react'
import ReactDOM from 'react-dom'
import { createStore, combineReducers } from 'redux'
import { Provider } from 'react-redux'
import { Router, Route, browserHistory } from 'react-router'
import { syncHistoryWithStore, routerReducer } from 'react-router-redux'
import { reducer as formReducer } from 'redux-form'

import App from './components/App'
import NominationsContainer from './containers/NominationsContainer'

import rootReducer from './reducers/rootReducer'

const store = createStore(
  combineReducers({
    rootReducer,
    form: formReducer,
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
          <Route path="teams/:team_id/nominations" component={NominationsContainer}/>
        </Route>
      </Router>
    </Provider>,
    reactElement
    );
  };
});
