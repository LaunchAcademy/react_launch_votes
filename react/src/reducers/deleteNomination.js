import {
  DELETE_NOMINATION_REQUEST,
  DELETE_NOMINATION_REQUEST_SUCCESS,
  DELETE_NOMINATION_REQUEST_FAILURE
} from '../actions/deleteNomination';

let initialState = {
  isDeletingNomination: false
}

const deleteNomination = (state = initialState, action) => {
  switch(action.type) {
    case DELETE_NOMINATION_REQUEST:
      return Object.assign({}, state, {
        isDeletingNomination: true
      });
    case DELETE_NOMINATION_REQUEST_SUCCESS:
      return Object.assign({}, state, {
        isDeletingNomination: false
      });
    case DELETE_NOMINATION_REQUEST_FAILURE:
      return Object.assign({}, state, {
        isDeletingNomination: false
      });
    default:
      return state;
  }
}

export default deleteNomination;
