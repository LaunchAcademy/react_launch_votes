import React from 'react';
import { reduxForm } from 'redux-form';
import NewNominationForm from '../components/NewNominationForm';

let validate = (fields) => {
  const errors = {};

  return errors;
}

let onSubmit = (fields) => {
  console.log(fields);
}

export default reduxForm({
  form: 'newNomination',
  validate,
  onSubmit
})(NewNominationForm)
