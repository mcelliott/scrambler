var TeamParticipant = React.createClass({
  render: function() {
    var data = this.props.data
    return (
      <div className="row flyer-list-item" id={"team-participant-" + data.id}>
        <div className="large-12 medium-12 small-12 columns">
          <div className="large-10 medium-10 small-6 columns">{data.name}</div>
          <div className="large-2 medium-2 small-4 columns text-right">
            <DeleteButton item={"team-participant-" + data.id} path={data.links.delete} confirm={'Delete Team Participant ' + data.name + '?'} />
          </div>
        </div>
      </div>
    );
  }
});