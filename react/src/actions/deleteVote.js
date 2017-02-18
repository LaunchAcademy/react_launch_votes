const DELETE_VOTE_REQUEST = "DELETE_VOTE_REQUEST";
const DELETE_VOTE_REQUEST_SUCCESS = "DELETE_VOTE_REQUEST_SUCCESS";
const DELETE_VOTE_REQUEST_FAILURE = "DELETE_VOTE_REQUEST_FAILURE";
const REMOVE_VOTE_FROM_PAGE = "REMOVE_VOTE_FROM_PAGE";

let deleteVoteRequest = () => {
  return {
    type: DELETE_VOTE_REQUEST
  };
};

let deleteVoteRequestSuccess = () => {
  return {
    type: DELETE_VOTE_REQUEST_SUCCESS
  };
};

let deleteVoteRequestFailure = () => {
  return {
    type: DELETE_VOTE_REQUEST_FAILURE
  };
};

let deleteVote = (voteId) => {
  return (dispatch) => {
    dispatch(deleteVoteRequest());
    return fetch(`/api/v1/votes/${voteId}.json`, {
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
      dispatch(deleteVoteRequestSuccess())
      dispatch(removeVoteFromPage(nomination))
    })
    .catch(errors => {
      dispatch(deleteVoteRequestFailure())
    })
  }
}

let removeVoteFromPage = (nomination) => {
  return {
    type: REMOVE_VOTE_FROM_PAGE,
    nomination
  }
}

export {
  DELETE_VOTE_REQUEST,
  DELETE_VOTE_REQUEST_SUCCESS,
  DELETE_VOTE_REQUEST_FAILURE,
  REMOVE_VOTE_FROM_PAGE
}

export {
  deleteVote,
  deleteVoteRequest,
  deleteVoteRequestSuccess,
  deleteVoteRequestFailure,
  removeVoteFromPage
}
