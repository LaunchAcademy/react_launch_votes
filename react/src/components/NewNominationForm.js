import React from 'react';
import { Field, reduxForm } from 'redux-form';

let NewNominationForm = ({ handleSubmit, pristine, submitting, team }) => {
  const options = team.team.users.map(user => {
    return(<option key={user.id} value={user.id}>{user.name} ({user.handle})</option>)
  })

  return (
    <div className="callout primary">
      <h3 className="text-center">Nominate A Fellow Launcher:</h3>
      <form onSubmit={handleSubmit}>
        <Field name="nominee_id" component="select" type="select">
          <option></option>
          {options}
        </Field>

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

export default NewNominationForm;
