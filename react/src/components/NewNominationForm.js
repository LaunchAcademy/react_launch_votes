import React from 'react';
import { Field, reduxForm } from 'redux-form';

let NewNominationForm = ({ currentUser, error, handleSubmit, pristine, submitting, team }) => {
  const options = team.users.map(user => {
    if (user.id != currentUser.id) {
      return(<option key={user.id} value={user.id}>{user.name} ({user.handle})</option>)
    }
  })

  if (error) {
    error = error.map(error => {
      return(<div className="callout alert" key={error}><i className="fa fa-exclamation-triangle"/>&nbsp;{error}</div>)
    })
  }

  return (
    <div className="callout primary">
      <h3 className="text-center">Nominate A Fellow Launcher:</h3>
      <form onSubmit={handleSubmit}>
        <Field name="nominee_id" component="select" type="select">
          {options}
        </Field>
        <Field name="body" component="input" type="text" placeholder="Most help requests" />
        {error}
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
