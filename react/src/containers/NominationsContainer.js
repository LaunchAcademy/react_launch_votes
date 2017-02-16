import React, { Component } from 'react';
import { connect } from 'react-redux';

import { getCurrentUser } from '../actions/getCurrentUser';
import { getTeam } from '../actions/getTeam';
import { postNomination } from '../actions/postNomination';
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
          return(<Nomination key={nomination.id} nomination={nomination} />)
        }
      })
    }
    return(
      <div>
        <h2>Hello from the <code>NominationsContainer.js</code> container.</h2>
        <div className="row">
          <div className="small-11 medium-7 small-centered columns">
            <NewNominationForm currentUser={this.props.currentUser.currentUser} team={this.props.teamData.team} onSubmit={this.postNomination} />
          </div>
        </div>
        <div className="row">
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
    getTeam: (teamId) => dispatch(getTeam(teamId))
  }
};

export default connect(mapStateToProps, mapDispatchToProps)(NominationsContainer);
