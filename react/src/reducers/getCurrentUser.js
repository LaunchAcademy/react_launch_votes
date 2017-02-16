import {
  GET_CURRENT_USER_REQUEST,
  GET_CURRENT_USER_REQUEST_SUCCESS,
  GET_CURRENT_USER_REQUEST_FAILURE
} from '../actions/getCurrentUser';

let initialState = {
  currentUser: {
    id: null
  },
  isFetchingCurrentUser: false
}

const currentUser = (state = initialState, action) => {
  switch(action.type) {
    case GET_CURRENT_USER_REQUEST:
      return Object.assign({}, state, {
        isFetchingCurrentUser: true
      });
    case GET_CURRENT_USER_REQUEST_SUCCESS:
      return Object.assign({}, state, {
        currentUser: action.currentUser,
        isFetchingCurrentUser: false
      });
    case GET_CURRENT_USER_REQUEST_FAILURE:
      return Object.assign({}, state, {
        isFetchingCurrentUser: false
      });
    default:
      return state;
  }
}

export default currentUser;
