const GET_NOMINATION_REQUEST = "GET_NOMINATION_REQUEST";
const GET_NOMINATION_REQUEST_SUCCESS = "GET_NOMINATION_REQUEST_SUCCESS";
const GET_NOMINATION_REQUEST_FAILURE = "GET_NOMINATION_REQUEST_FAILURE";

let getNominationRequest = () => {
  return {
    type: GET_NOMINATION_REQUEST
  };
};

let getNominationRequestSuccess = data => {
  return {
    type: GET_NOMINATION_REQUEST_SUCCESS,
    nomination: data
  };
}

let getNominationRequestFailure = () => {
  return {
    type: GET_NOMINATION_REQUEST_FAILURE
  };
}

let getNomination = (teamId, nominationId) => {
  return dispatch => {
    dispatch(getNominationRequest());
    fetch(`/api/v1/teams/${teamId}/nominations/${nominationId}.json`, {
      credentials: 'same-origin',
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
    .then((response) => response.json())
    .then((responseData) => dispatch(getNominationRequestSuccess(responseData)))
    .catch(() => dispatch(getNominationRequestFailure()))
  }
};

export {
  GET_NOMINATION_REQUEST,
  GET_NOMINATION_REQUEST_SUCCESS,
  GET_NOMINATION_REQUEST_FAILURE
};

export {
  getNomination,
  getNominationRequest,
  getNominationRequestSuccess,
  getNominationRequestFailure
};
