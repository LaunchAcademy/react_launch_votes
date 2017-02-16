import { SubmissionError, reset } from 'redux-form';

const POST_NOMINATION_REQUEST = "POST_NOMINATION_REQUEST";
const POST_NOMINATION_REQUEST_SUCCESS = "POST_NOMINATION_REQUEST_SUCCESS";
const POST_NOMINATION_REQUEST_FAILURE = "POST_NOMINATION_REQUEST_FAILURE";
const ADD_NOMINATION_TO_PAGE = "ADD_NOMINATION_TO_PAGE";

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
      dispatch(addNominationToPage(nomination))
      dispatch(reset('newNomination'))
    })
    .catch(errors => {
      dispatch(postNominationRequestFailure())
      throw new SubmissionError({'_error': errors});
    })
  }
}

let addNominationToPage = (nomination) => {
  return {
    type: ADD_NOMINATION_TO_PAGE,
    nomination
  }
}

export {
  POST_NOMINATION_REQUEST,
  POST_NOMINATION_REQUEST_SUCCESS,
  POST_NOMINATION_REQUEST_FAILURE,
  ADD_NOMINATION_TO_PAGE
}

export {
  postNomination,
  postNominationRequest,
  postNominationRequestSuccess,
  postNominationRequestFailure,
  addNominationToPage
}
