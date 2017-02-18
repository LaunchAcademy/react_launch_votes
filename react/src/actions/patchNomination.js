import { SubmissionError, reset } from 'redux-form';
import { push } from 'react-router-redux';

const PATCH_NOMINATION_REQUEST = "PATCH_NOMINATION_REQUEST";
const PATCH_NOMINATION_REQUEST_SUCCESS = "PATCH_NOMINATION_REQUEST_SUCCESS";
const PATCH_NOMINATION_REQUEST_FAILURE = "PATCH_NOMINATION_REQUEST_FAILURE";
const ADD_NOMINATION_TO_PAGE = "ADD_NOMINATION_TO_PAGE";

let patchNominationRequest = () => {
  return {
    type: PATCH_NOMINATION_REQUEST
  };
};

let patchNominationRequestSuccess = () => {
  return {
    type: PATCH_NOMINATION_REQUEST_SUCCESS
  };
};

let patchNominationRequestFailure = () => {
  return {
    type: PATCH_NOMINATION_REQUEST_FAILURE
  };
};

let patchNomination = (values) => {
  let payload = JSON.stringify(values)
  return (dispatch, getState) => {
    dispatch(patchNominationRequest());
    let nominationId = getState().nomination.nomination.id
    let teamId = getState().team.team.id
    return fetch(`/api/v1/teams/${teamId}/nominations/${nominationId}.json`, {
      credentials: 'same-origin',
      method: 'PATCH',
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
        return { team: data };
      } else {
        throw(data.errors);
      }
    })
    .then(team => {
      dispatch(patchNominationRequestSuccess())
      dispatch(push(`/teams/${team.team.id}/nominations`))
    })
    .catch(errors => {
      dispatch(patchNominationRequestFailure())
      throw new SubmissionError({'_error': errors});
    })
  }
}

export {
  PATCH_NOMINATION_REQUEST,
  PATCH_NOMINATION_REQUEST_SUCCESS,
  PATCH_NOMINATION_REQUEST_FAILURE
}

export {
  patchNomination,
  patchNominationRequest,
  patchNominationRequestSuccess,
  patchNominationRequestFailure
}
