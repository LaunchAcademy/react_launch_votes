import React, { Component } from 'react';
import { connect } from 'react-redux';

import { getTeam } from '../actions/getTeam';
import NewNominationForm from '../components/NewNominationForm'

class NominationsContainer extends Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    let teamId = this.props.params.teamId;
    this.props.getTeam(teamId)
  }

  postNomination(fields, dispatch) {
    console.log(fields);
  }

  render() {
    return(
      <div>
        <h2>Hello from the <code>NominationsContainer.js</code> container.</h2>
        <div className="row">
          <div className="small-11 medium-7 small-centered columns">
            <NewNominationForm team={this.props.team} onSubmit={this.postNomination} />
          </div>
        </div>
      </div>
    )
  }
};

let mapStateToProps = state => {
  return {
    team: state.team
  }
};

let mapDispatchToProps = dispatch => {
  return {
    getTeam: (teamId) => dispatch(getTeam(teamId))
  }
};

export default connect(mapStateToProps, mapDispatchToProps)(NominationsContainer);
