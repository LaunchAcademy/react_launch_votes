import React from 'react';

let Nomination = ({ nomination }) => {
  return (
    <div className="column">
      <div className="callout secondary text-center">
        <img className="nomination" src={nomination.nominee.image_url} />
        <div>
          <span className="label position-top-minus-one"><i className="fa fa-github" />&nbsp;{nomination.nominee.handle}</span>
          <h4 className="pink">{nomination.nominee.name}</h4>
          <h5>{nomination.body}</h5>
        </div>
      </div>
    </div>
  );
}

export default Nomination;
