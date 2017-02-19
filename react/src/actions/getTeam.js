const GET_TEAM_REQUEST = "GET_TEAM_REQUEST";
const GET_TEAM_REQUEST_SUCCESS = "GET_TEAM_REQUEST_SUCCESS";
const GET_TEAM_REQUEST_FAILURE = "GET_TEAM_REQUEST_FAILURE";

let getTeamRequest = () => {
  return {
    type: GET_TEAM_REQUEST
  };
};

let getTeamRequestSuccess = data => {
  return {
    type: GET_TEAM_REQUEST_SUCCESS,
    team: data
  };
};

let getTeamRequestFailure = () => {
  return {
    type: GET_TEAM_REQUEST_FAILURE
  };
};

let getTeam = (teamId) => {
  return dispatch => {
    dispatch(getTeamRequest());
    fetch(`/api/v1/teams/${teamId}.json`, {
      credentials: 'same-origin',
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
    .then((response) => response.json())
    .then((responseData) => dispatch(getTeamRequestSuccess(responseData)))
    .catch(() => dispatch(getTeamRequestFailure()))
  };
};

export {
  GET_TEAM_REQUEST,
  GET_TEAM_REQUEST_SUCCESS,
  GET_TEAM_REQUEST_FAILURE
};

export {
  getTeam,
  getTeamRequest,
  getTeamRequestSuccess,
  getTeamRequestFailure
};
