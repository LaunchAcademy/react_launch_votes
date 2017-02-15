import {
  GET_TEAM_REQUEST,
  GET_TEAM_REQUEST_SUCCESS,
  GET_TEAM_REQUEST_FAILURE
} from '../actions/getTeam';

import {
  ADD_NOMINATION_TO_PAGE
} from '../actions/postNomination';

let initialState = {
  team: {
    id: null,
    name: '',
    nominations: [],
    users: []
  },
  isFetchingTeam: false
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
    case ADD_NOMINATION_TO_PAGE:
      let newNominations = [action.nomination.nomination].concat(state.team.nominations);
      return Object.assign({}, state, {
        team: {
          id: state.team.id,
          name: state.team.name,
          nominations: newNominations,
          users: state.team.users
        }
      });
    default:
      return state;
  }
}

export default team;
