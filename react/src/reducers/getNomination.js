import {
  GET_NOMINATION_REQUEST,
  GET_NOMINATION_REQUEST_SUCCESS,
  GET_NOMINATION_REQUEST_FAILURE
} from '../actions/getNomination';

let initialState = {
  nomination: {
    id: null,
    body: null,
    nominator_id: null,
    nominee_id: null,
    nominee: {},
    voter_ids: {}
  },
  isFetchingNomination: false
}

const nomination = (state = initialState, action) => {
  switch(action.type) {
    case GET_NOMINATION_REQUEST:
      return Object.assign({}, state, {
        isFetchingNomination: true
      });
    case GET_NOMINATION_REQUEST_SUCCESS:
      return Object.assign({}, state, {
        nomination: action.nomination,
        isFetchingNomination: false
      });
    case GET_NOMINATION_REQUEST_FAILURE:
      return Object.assign({}, state, {
        isFetchingNomination: false
      });
    default:
      return state;
  }
}

export default nomination;
