import {
  GET_TEAM_REQUEST,
  GET_TEAM_REQUEST_SUCCESS,
  GET_TEAM_REQUEST_FAILURE
} from '../actions/getTeam';

import {
  ADD_NOMINATION_TO_PAGE
} from '../actions/postNomination';

import {
  ADD_VOTE_TO_PAGE
} from '../actions/postVote';

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
    case ADD_VOTE_TO_PAGE:
      let voteAddedNominations;
      voteAddedNominations = state.team.nominations;
      let nominationIndex = voteAddedNominations.findIndex(nomination => nomination.id == action.nomination.nomination.id);
      voteAddedNominations.splice(nominationIndex, 1, action.nomination.nomination);
      return Object.assign({}, state, {
        team: {
          id: state.team.id,
          name: state.team.name,
          nominations: voteAddedNominations,
          users: state.team.users
        }
      })
    default:
      return state;
  }
}

export default team;
