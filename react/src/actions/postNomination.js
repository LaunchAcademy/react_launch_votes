const POST_NOMINATION_REQUEST = "POST_NOMINATION_REQUEST";
const POST_NOMINATION_REQUEST_SUCCESS = "POST_NOMINATION_REQUEST_SUCCESS";
const POST_NOMINATION_REQUEST_FAILURE = "POST_NOMINATION_REQUEST_FAILURE";

let postNominationRequest = () => {
  return {
    type: POST_NOMINATION_REQUEST
  };
};

let postNominationRequestSuccess = data => {
  return {
    type: POST_NOMINATION_REQUEST_SUCCESS,
    nomination: data
  };
};

let postNominationRequestFailure = () => {
  return {
    type: POST_NOMINATION_REQUEST_FAILURE
  };
};

let postNomination = (values) => {
  let payload = JSON.stringify(values)
  return (dispatch, getState) => {
    dispatch(postNominationRequest());
    let teamId = getState().team.team.id
    return fetch(`/api/v1/teams/${teamId}/nominations.json`, {
      credentials: 'same-origin',
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: payload
    })
    .then(response => {
      let { ok, status, statusText } = response;
      debugger
      dispatch(postNominationRequestSuccess(response.json()))
    })
    .catch(error => {
      dispatch(postNominationRequestFailure());
    })
  }
}

export {
  POST_NOMINATION_REQUEST,
  POST_NOMINATION_REQUEST_SUCCESS,
  POST_NOMINATION_REQUEST_FAILURE
}

export {
  postNomination,
  postNominationRequest,
  postNominationRequestSuccess,
  postNominationRequestFailure
}
