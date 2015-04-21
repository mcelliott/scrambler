var Participants = React.createClass({
  render: function() {
    var category_participants = _.sortBy( this.props.data, 'category_name' );
    return (
      <div className="large-12 medium-12 small-12 columns">
        <ul>
          {category_participants.map(function(cp){
            return (
              <li className="participant-category" id={"category-" + cp.category_id}>
                <div className="custom-panel">
                  <div className="panel-header">
                    <div className="right">
                      <DeleteButton item={"category-" + cp.category_id} path={cp.links.delete} confirm={"Delete Participant Category " + cp.category_name + "?"} />
                    </div>
                    { cp.category_name }
                  </div>
                  <div className="panel-content">
                    {cp.participants.map(function(participant){
                      return (
                        <Participant data={participant} />
                      );
                    }, this)}
                  </div>
                </div>
              </li>
            );
          }, this)}
        </ul>
      </div>
    );
  }
});