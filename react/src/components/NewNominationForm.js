import React from 'react';
import { Field } from 'redux-form';


let ReduxTextField = ({ input, meta: { touched, error }, placeholder, id }) => {
  return (
    <div>
      <div>
        <input {...input} placeholder={placeholder} type='text' id={id} />
      </div>
      <div>
        { touched && error && <span className="form-error">{error}</span> }
      </div>
    </div>
  )
}

let NewNominationForm = ({handleSubmit}) => {
  return (
    <div className="callout primary">
      <h3 className="text-center">Nominate A Fellow Launcher:</h3>
      <form onSubmit={handleSubmit}>
        <fieldset>
          <Field name="nominee_id" component="select">
            <option value="331">aimeebachari</option>
          </Field>
        </fieldset>
        <fieldset>
          <Field
            name="body" key="body"
            placeholder="Most Help Requests"
            component={ReduxTextField}
          />
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

export default NewNominationForm;
