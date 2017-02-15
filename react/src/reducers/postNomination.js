import {
  POST_NOMINATION_REQUEST,
  POST_NOMINATION_REQUEST_SUCCESS,
  POST_NOMINATION_REQUEST_FAILURE
} from '../actions/postNomination';

let initialState = {
  isPostingNomination: false
}

const postNomination = (state = initialState, action) => {
  switch(action.type) {
    case POST_NOMINATION_REQUEST:
      return Object.assign({}, state, {
        isPostingNomination: true
      });
    case POST_NOMINATION_REQUEST_SUCCESS:
      return Object.assign({}, state, {
        isPostingNomination: false
      });
    case POST_NOMINATION_REQUEST_FAILURE:
      return Object.assign({}, state, {
        isPostingNomination: false
      });
    default:
      return state;
  }
}

export default postNomination;
