var Event = React.createClass({
getInitialState: function() {
    return {
      links: {},
      round_path: this.props.round_path,
      category_participants: [],
      rounds: []
    };
  },
  generate: function(path) {
    $('div.generating-teams').show()
    var refresh = this.refresh;
    $.ajax({
      type: 'POST',
      url: this.props.round_path,
      dataType: 'script',
      success: function (data) {
        $('div.generating-teams').hide();
        refresh();
      }
    });
  },
  refresh: function() {
    $.ajax({
      type: 'GET',
      url: this.props.path,
      dataType: 'json',
      success: function(data) {
        this.setState({
          links: data.event.links,
          category_participants: data.event.category_participants,
          rounds: data.event.rounds
        });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.path, status, err.toString());
      }.bind(this)
    });
  },
  componentDidMount: function() {
    this.refresh();
  },
  render: function() {
    return (
      <div className="event">
        <div className="large-12 medium-12 small-12 columns">
          <div className='panel event-panel'>
            <div className="row collapse">
              <ul className="actions-list">
                <li><EventButton path={this.state.links.edit} icon='plus' text='Edit Event' /></li>
                <li><LinkButton path={this.state.links.expenses} icon='money' text='Expenses'/></li>
                <li><EventButton path={this.state.links.add} icon='plus' text='Add Participants'/></li>
                <li><GenerateButton onClick={this.generate} links={this.state.links} /></li>
                <li><LinkButton path={this.state.links.scoreboard} icon='table' text='Score Board' id="show-score-board" /></li>
              </ul>
            </div>
          </div>
        </div>
        <Rounds category_participants={this.state.category_participants} rounds={this.state.rounds} />
      </div>
    );
  }
});
