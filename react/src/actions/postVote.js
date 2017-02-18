const POST_VOTE_REQUEST = "POST_VOTE_REQUEST";
const POST_VOTE_REQUEST_SUCCESS = "POST_VOTE_REQUEST_SUCCESS";
const POST_VOTE_REQUEST_FAILURE = "POST_VOTE_REQUEST_FAILURE";
const ADD_VOTE_TO_PAGE = "ADD_VOTE_TO_PAGE";

let postVoteRequest = () => {
  return {
    type: POST_VOTE_REQUEST
  };
};

let postVoteRequestSuccess = () => {
  return {
    type: POST_VOTE_REQUEST_SUCCESS
  };
};

let postVoteRequestFailure = () => {
  return {
    type: POST_VOTE_REQUEST_FAILURE
  };
};

let postVote = (nominationId) => {
  let payload = JSON.stringify({ nomination_id: nominationId })
  return (dispatch, getState) => {
    dispatch(postVoteRequest());
    return fetch('/api/v1/votes.json', {
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
      dispatch(postVoteRequestSuccess())
      dispatch(addVoteToPage(nomination))
    })
    .catch(errors => {
      dispatch(postVoteRequestFailure())
    })
  }
}

let addVoteToPage = (nomination) => {
  return {
    type: ADD_VOTE_TO_PAGE,
    nomination
  }
}

export {
  POST_VOTE_REQUEST,
  POST_VOTE_REQUEST_SUCCESS,
  POST_VOTE_REQUEST_FAILURE,
  ADD_VOTE_TO_PAGE
}

export {
  postVote,
  postVoteRequest,
  postVoteRequestSuccess,
  postVoteRequestFailure,
  addVoteToPage
}
