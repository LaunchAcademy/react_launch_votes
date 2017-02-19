import 'babel-polyfill';
import 'whatwg-fetch';
import React from 'react'
import ReactDOM from 'react-dom'
import { createStore, combineReducers, applyMiddleware } from 'redux'
import { Provider } from 'react-redux'
import { Router, Route, browserHistory } from 'react-router'
import { syncHistoryWithStore, routerMiddleware, routerReducer } from 'react-router-redux'
import { reducer as formReducer } from 'redux-form'
import thunkMiddleware from 'redux-thunk';

import App from './components/App'
import EditNominationFormContainer from './containers/EditNominationFormContainer'
import NominationsContainer from './containers/NominationsContainer'

import currentUser from './reducers/getCurrentUser'
import deleteNomination from './reducers/deleteNomination'
import deleteVote from './reducers/deleteVote'
import nomination from './reducers/getNomination'
import patchNomination from './reducers/patchNomination'
import postNomination from './reducers/postNomination'
import team from './reducers/getTeam'
import vote from './reducers/postVote'

const store = createStore(
  combineReducers({
    currentUser,
    deleteNomination,
    deleteVote,
    nomination,
    patchNomination,
    postNomination,
    team,
    vote,
    form: formReducer,
    routing: routerReducer
  }),
  applyMiddleware(thunkMiddleware, routerMiddleware(browserHistory))
)

const history = syncHistoryWithStore(browserHistory, store)

$(function() {
  let reactElement = document.getElementById('app');
  if (reactElement) {
    ReactDOM.render(
    <Provider store={store}>
      <Router history={history}>
        <Route path="/" component={App}>
          <Route path="teams/:teamId/nominations" component={NominationsContainer}/>
          <Route path="teams/:teamId/nominations/:nominationId/edit" component={EditNominationFormContainer} />
        </Route>
      </Router>
    </Provider>,
    reactElement
    );
  };
});
