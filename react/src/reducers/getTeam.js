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

import {
  REMOVE_NOMINATION_FROM_PAGE
} from '../actions/deleteNomination';

import {
  REMOVE_VOTE_FROM_PAGE
} from '../actions/deleteVote';

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
  let downvotedNominationIndex;
  let newNominations;
  let nominationRemoved;
  let upvotedNominationIndex;
  let removedNominationIndex;
  let voteRemovedNominations;
  let voteAddedNominations;
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
      newNominations = [action.nomination.nomination].concat(state.team.nominations);
      return Object.assign({}, state, {
        team: {
          id: state.team.id,
          name: state.team.name,
          nominations: newNominations,
          users: state.team.users
        }
      });
    case ADD_VOTE_TO_PAGE:
      voteAddedNominations = state.team.nominations;
      upvotedNominationIndex = voteAddedNominations.findIndex(nomination => nomination.id === action.nomination.nomination.id);
      voteAddedNominations.splice(upvotedNominationIndex, 1, action.nomination.nomination);
      return Object.assign({}, state, {
        team: {
          id: state.team.id,
          name: state.team.name,
          nominations: voteAddedNominations,
          users: state.team.users
        }
      });
    case REMOVE_NOMINATION_FROM_PAGE:
      nominationRemoved = state.team.nominations;
      removedNominationIndex = nominationRemoved.findIndex(nomination => nomination.id === action.nomination.nomination.id);
      nominationRemoved.splice(removedNominationIndex, 1);
      return Object.assign({}, state, {
        team: {
          id: state.team.id,
          name: state.team.name,
          nominations: nominationRemoved,
          users: state.team.users
        }
      });
    case REMOVE_VOTE_FROM_PAGE:
      voteRemovedNominations = state.team.nominations;
      downvotedNominationIndex = voteRemovedNominations.findIndex(nomination => nomination.id === action.nomination.nomination.id);
      voteRemovedNominations.splice(downvotedNominationIndex, 1, action.nomination.nomination);
      return Object.assign({}, state, {
        team: {
          id: state.team.id,
          name: state.team.name,
          nominations: voteRemovedNominations,
          users: state.team.users
        }
      });
    default:
      return state;
  }
}

export default team;
