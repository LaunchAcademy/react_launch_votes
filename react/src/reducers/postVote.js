import {
  POST_VOTE_REQUEST,
  POST_VOTE_REQUEST_SUCCESS,
  POST_VOTE_REQUEST_FAILURE
} from '../actions/postVote';

let initialState = {
  isPostingVote: false
}

const postVote = (state = initialState, action) => {
  switch(action.type) {
    case POST_VOTE_REQUEST:
      return Object.assign({}, state, {
        isPostingVote: true
      });
    case POST_VOTE_REQUEST_SUCCESS:
      return Object.assign({}, state, {
        isPostingVote: false
      });
    case POST_VOTE_REQUEST_FAILURE:
      return Object.assign({}, state, {
        isPostingVote: false
      });
    default:
      return state;
  }
}

export default postVote;
