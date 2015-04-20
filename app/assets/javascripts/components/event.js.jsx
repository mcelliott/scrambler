var Event = React.createClass({
getInitialState: function() {
    return { links: {}, rounds: this.props.rounds };
  },
  generate: function(path) {
    $('div.generating-teams').show()
    $.ajax({
      type: 'POST',
      url: this.props.rounds,
      dataType: 'script',
      success: function (data) {
        $('div.generating-teams').hide();
      }
    }).fail(function(xhr, status, err) {
      console.log(err.toString());
    });
  },
  componentDidMount: function() {
    $.ajax({
      type: 'GET',
      url: this.props.path,
      dataType: 'json',
      success: function(data) {
        this.setState({ links: data.event.links });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.path, status, err.toString());
      }.bind(this)
    });
  },
  render: function() {
    return (
      <div className="event">
        <div className="large-12 medium-12 small-12 columns">
          <div className='panel event-panel'>
            <div className="row collapse">
              <ul className="actions-list">
                <li><EventButton path={this.state.links.edit} icon='plus' text='Edit Event' /></li>
                <li><EventButton path={this.state.links.expenses} icon='money' text='Expenses'/></li>
                <li><EventButton path={this.state.links.add} icon='plus' text='Add Participants'/></li>
                <li><GenerateButton onClick={this.generate} links={this.state.links} /></li>
                <li><EventButton path={this.state.links.scoreboard} icon='table' text='Score Board' id="show-score-board" /></li>
              </ul>
            </div>
          </div>
        </div>
        <Rounds path={this.state.rounds} />
      </div>
    );
  }
});
