var Participant = React.createClass({
  render: function() {
    var participant = this.props.data;
    return (
      <div className="row flyer-list-item" id={"participant-" + participant.id}>
        <div className="large-12 medium-12 small-12 columns">
          <div className="large-7 small-6 columns participant-name">{participant.number}. {participant.name}</div>
          <div className="large-5 small-6 columns text-right">
            <GetButton path={participant.links.info} icon="info" />
            <DeleteButton item={"participant-" + participant.id} path={participant.links.delete} confirm={'Delete Participant ' + participant.name + '?'} />
          </div>
        </div>
      </div>
    );
  }
});