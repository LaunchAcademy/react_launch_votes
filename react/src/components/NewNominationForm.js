import React from 'react';
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form';

let NewNominationForm = props => {
  const { handleSubmit, pristine, submitting, team } = props

  const options = team.team.users.map(user => {
    return(<option key={user.id} value={user.id}>{user.name} ({user.handle})</option>)
  })

  return (
    <div className="callout primary">
      <h3 className="text-center">Nominate A Fellow Launcher:</h3>
      <form onSubmit={handleSubmit}>
        <fieldset>
          <Field name="nominee_id" component="select">
            {options}
          </Field>
        </fieldset>

        <div className="text-center">
          <button className="hollow button secondary" type="submit">
            Submit
          </button>
        </div>
      </form>
    </div>
  );
}

NewNominationForm = reduxForm({
  form: 'newNomination'
})(NewNominationForm)

NewNominationForm = connect(
  state => ({
    initialValues: state,
  })
)(NewNominationForm)

export default NewNominationForm;
