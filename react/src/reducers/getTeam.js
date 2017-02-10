import {
  GET_TEAM_REQUEST,
  GET_TEAM_REQUEST_SUCCESS,
  GET_TEAM_REQUEST_FAILURE
} from '../actions/getTeam';

let initialState = {
  team: {
    users: []
  }
}

const team = (state = initialState, action) => {
  switch(action.type) {
    case GET_TEAM_REQUEST:
      return Object.assign({}, state, {
        isFetchingTeam: true
      });
    case GET_TEAM_REQUEST_SUCCESS:
      return Object.assign({}, state, {
        team: action.team,
        isFetchingTeam: false
      });
    case GET_TEAM_REQUEST_FAILURE:
      return Object.assign({}, state, {
        isFetchingTeam: false
      });
    default:
      return state;
  }
}

export default team;
