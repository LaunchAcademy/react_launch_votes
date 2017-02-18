import React, { Component } from 'react';
import { connect } from 'react-redux';

import { deleteVote } from '../actions/deleteVote';
import { getCurrentUser } from '../actions/getCurrentUser';
import { getTeam } from '../actions/getTeam';
import { postNomination } from '../actions/postNomination';
import { postVote } from '../actions/postVote';
import NewNominationForm from '../components/NewNominationForm';
import Nomination from '../components/Nomination';

class NominationsContainer extends Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    this.props.getCurrentUser();
    let teamId = this.props.params.teamId;
    this.props.getTeam(teamId);
  }

  postNomination(fields, dispatch) {
    return dispatch(postNomination(fields));
  }

  render() {
    let nominations;
    let currentUser = this.props.currentUser.currentUser
    if (this.props.currentUser && this.props.teamData.team) {
      nominations = this.props.teamData.team.nominations.map(nomination => {
        if (nomination.nominee_id != currentUser.id) {
          return(<Nomination key={nomination.id} currentUser={currentUser} nomination={nomination} teamId={this.props.params.teamId} voteHandler={this.props.voteHandler} />)
        }
      })
    }
    return(
      <div>
        <div className="row">
          <div className="small-11 medium-7 small-centered columns">
            <NewNominationForm currentUser={this.props.currentUser.currentUser} team={this.props.teamData.team} onSubmit={this.postNomination} />
          </div>
        </div>
        <div className="row small-up-1 medium-up-3 large-up-4">
          {nominations}
        </div>
      </div>
    )
  }
};

let mapStateToProps = state => {
  return {
    currentUser: state.currentUser,
    teamData: state.team
  }
};

let mapDispatchToProps = dispatch => {
  return {
    getCurrentUser: () => dispatch(getCurrentUser()),
    getTeam: (teamId) => dispatch(getTeam(teamId)),
    voteHandler: (nominationId, voteId) => {
      if (voteId) {
        dispatch(deleteVote(voteId))
      } else {
        dispatch(postVote(nominationId))
      }
    }
  }
};

export default connect(mapStateToProps, mapDispatchToProps)(NominationsContainer);
