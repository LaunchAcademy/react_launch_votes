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
  return (dispatch, getState) => {
    let teamId = getState().team.team.id
    dispatch(postNominationRequest())
    debugger
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
