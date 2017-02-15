const POST_NOMINATION_REQUEST = "POST_NOMINATION_REQUEST";
const POST_NOMINATION_REQUEST_SUCCESS = "POST_NOMINATION_REQUEST_SUCCESS";
const POST_NOMINATION_REQUEST_FAILURE = "POST_NOMINATION_REQUEST_FAILURE";

let postNominationRequest = () => {
  return {
    type: POST_NOMINATION_REQUEST
  };
};

let postNominationRequestSuccess = () => {
  return {
    type: POST_NOMINATION_REQUEST_SUCCESS
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
      let { status } = response;
      if (status == 500) {
        throw('Server Error.')
      } else {
        return response.json();
      }
    })
    .then(data => {
      if (typeof data.errors === "undefined") {
        return { nomination: data };
      } else {
        throw(data.errors);
      }
    })
    .then(nomination => {
      dispatch(postNominationRequestSuccess())
    })
    .catch(errors => {
      dispatch(postNominationRequestFailure())
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
