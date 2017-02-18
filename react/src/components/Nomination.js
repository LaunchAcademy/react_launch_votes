import React from 'react';
import Vote from './Vote';

let Nomination = ({ currentUser, nomination }) => {
  let voteText;
  if (nomination.voter_ids.includes(currentUser.id)) {
    voteText = "Voted"
  } else {
    voteText = "Vote"
  }
  return (
    <div className="column">
      <div className="callout secondary text-center">
        <Vote voteText={voteText} />
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
