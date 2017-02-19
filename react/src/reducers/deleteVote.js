import {
  DELETE_VOTE_REQUEST,
  DELETE_VOTE_REQUEST_SUCCESS,
  DELETE_VOTE_REQUEST_FAILURE
} from '../actions/deleteVote';

let initialState = {
  isDeletingVote: false
}

const deleteVote = (state = initialState, action) => {
  switch(action.type) {
    case DELETE_VOTE_REQUEST:
      return Object.assign({}, state, {
        isDeletingVote: true
      });
    case DELETE_VOTE_REQUEST_SUCCESS:
      return Object.assign({}, state, {
        isDeletingVote: false
      });
    case DELETE_VOTE_REQUEST_FAILURE:
      return Object.assign({}, state, {
        isDeletingVote: false
      });
    default:
      return state;
  }
}

export default deleteVote;
