import {
  PATCH_NOMINATION_REQUEST,
  PATCH_NOMINATION_REQUEST_SUCCESS,
  PATCH_NOMINATION_REQUEST_FAILURE
} from '../actions/patchNomination';

let initialState = {
  isPatchingNomination: false
}

const patchNomination = (state = initialState, action) => {
  switch(action.type) {
    case PATCH_NOMINATION_REQUEST:
      return Object.assign({}, state, {
        isPatchingNomination: true
      });
    case PATCH_NOMINATION_REQUEST_SUCCESS:
      return Object.assign({}, state, {
        isPatchingNomination: false
      });
    case PATCH_NOMINATION_REQUEST_FAILURE:
      return Object.assign({}, state, {
        isPatchingNomination: false
      });
    default:
      return state;
  }
}

export default patchNomination;
