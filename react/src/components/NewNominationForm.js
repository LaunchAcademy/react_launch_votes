import React from 'react';
import { Field, reduxForm } from 'redux-form';

let NewNominationForm = ({ currentUser, handleSubmit, pristine, submitting, team, teamId }) => {
  const options = team.users.map(user => {
    if (user.id != currentUser.id) {
      return(<option key={user.id} value={user.id}>{user.name} ({user.handle})</option>)
    }
  })

  return (
    <div className="callout primary">
      <h3 className="text-center">Nominate A Fellow Launcher:</h3>
      <form onSubmit={handleSubmit}>
        <Field name="nominee_id" component="select" type="select">
          <option></option>
          {options}
        </Field>
        <Field name="body" component="input" type="text" placeholder="Most help requests" />
        <div className="text-center">
          <button className="button secondary" disabled={pristine || submitting} type="submit">
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

export default NewNominationForm;