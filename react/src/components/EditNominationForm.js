import React from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router';
import { Field, reduxForm } from 'redux-form';

let EditNominationForm = ({ currentUser, error, handleSubmit, nomination, pristine, submitting, teamId }) => {
  return(
    <div className="callout secondary text-center">
      <img className="nomination" src={nomination.nominee.image_url} />
      <div>
        <span className="label position-top-minus-one"><i className="fa fa-github" />&nbsp;{nomination.nominee.handle}</span>
        <h3 className="pink">{nomination.nominee.name}</h3>
      </div>
      <form onSubmit={handleSubmit}>
        <Field name="body" component="input" type="text" />
        <div className="button-group">
          <button className="button" disabled={pristine || submitting} type="submit">
            Edit
          </button>
          <Link className="button" to={`/teams/${teamId}/nominations`}>Cancel</Link>
        </div>
      </form>
    </div>
  )
}

let mapStateToProps = state => {
  let { body } = state.nomination.nomination
  return {
    initialValues: { body }
  }
}

EditNominationForm = reduxForm({
  form: 'editNomination',
  enableReinitialize: true
})(EditNominationForm)

export default connect(
  mapStateToProps
)(EditNominationForm)
