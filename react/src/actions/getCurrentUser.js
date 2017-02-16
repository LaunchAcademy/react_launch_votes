const GET_CURRENT_USER_REQUEST = "GET_CURRENT_USER_REQUEST";
const GET_CURRENT_USER_REQUEST_SUCCESS = "GET_CURRENT_USER_REQUEST_SUCCESS";
const GET_CURRENT_USER_REQUEST_FAILURE = "GET_CURRENT_USER_REQUEST_FAILURE";

let getCurrentUserRequest = () => {
  return {
    type: GET_CURRENT_USER_REQUEST
  };
};

let getCurrentUserRequestSuccess = data => {
  return {
    type: GET_CURRENT_USER_REQUEST_SUCCESS,
    currentUser: data
  };
};

let getCurrentUserRequestFailure = () => {
  return {
    type: GET_CURRENT_USER_REQUEST_FAILURE
  };
};

let getCurrentUser = () => {
  return dispatch => {
    dispatch(getCurrentUserRequest());
    fetch('/api/v1/users/current', {
      credentials: 'same-origin',
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
    .then((response) => response.json())
    .then((responseData) => dispatch(getCurrentUserRequestSuccess(responseData)))
    .catch(() => dispatch(getCurrentUserRequestFailure()))
  };
};

export {
  GET_CURRENT_USER_REQUEST,
  GET_CURRENT_USER_REQUEST_SUCCESS,
  GET_CURRENT_USER_REQUEST_FAILURE
};

export {
  getCurrentUser,
  getCurrentUserRequest,
  getCurrentUserRequestSuccess,
  getCurrentUserRequestFailure
};
