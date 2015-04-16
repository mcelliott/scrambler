var TeamParticipant = React.createClass({
  render: function() {
    var data = this.props.data
    return (
      <div className="row flyer-list-item">
        <div className="large-12 medium-12 small-12 columns">
          <div className="small-4 columns">
            {data.name}
          </div>
          <div className="small-4 columns">
            {data.category}
          </div>
          <div className="small-3 columns">
            {data.hours}
          </div>
          <div className="small-1 columns text-right">
            <DeleteButton path={data.path} confirm={'Delete Team Participant ' + data.name + '?'} />
          </div>
        </div>
      </div>
    );
  }
});