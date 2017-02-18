import React, { Component } from 'react';
import { reduxForm } from 'redux-form';
import { connect } from 'react-redux';

import { getCurrentUser } from '../actions/getCurrentUser';
import { getNomination } from '../actions/getNomination';
import { patchNomination } from '../actions/patchNomination'
import EditNominationForm from '../components/EditNominationForm';

class EditNominationFormContainer extends Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    this.props.getCurrentUser();
    let nominationId = this.props.params.nominationId;
    let teamId = this.props.params.teamId;
    this.props.getNomination(teamId, nominationId);
  }

  patchNomination(fields, dispatch) {
    return dispatch(patchNomination(fields));
  }

  render() {
    return(
      <div className="row">
        <div className="small-11 medium-7 small-centered columns">
          <EditNominationForm currentUser={this.props.currentUser.currentUser} nomination={this.props.nominationData.nomination} onSubmit={this.patchNomination} teamId={this.props.params.teamId} />
        </div>
      </div>
    )
  }
};

let mapStateToProps = state => {
  return {
    currentUser: state.currentUser,
    nominationData: state.nomination
  }
};

let mapDispatchToProps = dispatch => {
  return {
    getCurrentUser: () => dispatch(getCurrentUser()),
    getNomination: (teamId, nominationId) => dispatch(getNomination(teamId, nominationId))
  }
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(EditNominationFormContainer);
