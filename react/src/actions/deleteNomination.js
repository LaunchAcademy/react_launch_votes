const DELETE_NOMINATION_REQUEST = "DELETE_NOMINATION_REQUEST";
const DELETE_NOMINATION_REQUEST_SUCCESS = "DELETE_NOMINATION_REQUEST_SUCCESS";
const DELETE_NOMINATION_REQUEST_FAILURE = "DELETE_NOMINATION_REQUEST_FAILURE";
const REMOVE_NOMINATION_FROM_PAGE = "REMOVE_NOMINATION_FROM_PAGE";

let deleteNominationRequest = () => {
  return {
    type: DELETE_NOMINATION_REQUEST
  };
};

let deleteNominationRequestSuccess = () => {
  return {
    type: DELETE_NOMINATION_REQUEST_SUCCESS
  };
};

let deleteNominationRequestFailure = () => {
  return {
    type: DELETE_NOMINATION_REQUEST_FAILURE
  };
};

let deleteNomination = (nominationId) => {
  return (dispatch) => {
    dispatch(deleteNominationRequest());
    return fetch(`/api/v1/nominations/${nominationId}.json`, {
      credentials: 'same-origin',
      method: 'DELETE',
      headers: { 'Content-Type': 'application/json' }
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
      if (typeof data.errors == "undefined") {
        return {nomination: data};
      } else {
        throw(data.errors);
      }
    })
    .then(nomination => {
      dispatch(deleteNominationRequestSuccess())
      dispatch(removeNominationFromPage(nomination))
    })
    .catch(errors => {
      dispatch(deleteNominationRequestFailure())
    })
  }
}

let removeNominationFromPage = (nomination) => {
  return {
    type: REMOVE_NOMINATION_FROM_PAGE,
    nomination
  }
}

export {
  DELETE_NOMINATION_REQUEST,
  DELETE_NOMINATION_REQUEST_SUCCESS,
  DELETE_NOMINATION_REQUEST_FAILURE,
  REMOVE_NOMINATION_FROM_PAGE
}

export {
  deleteNomination,
  deleteNominationRequest,
  deleteNominationRequestSuccess,
  deleteNominationRequestFailure,
  removeNominationFromPage
}
