var InfoButton = React.createClass({
  fetch: function() {
    $.ajax({
      type: 'GET',
      url: this.props.path,
      dataType: 'script',
      success: function (data) {}
    }).fail(function(xhr, status, err) {
      console.error(this.props.path, status, err.toString());
    });
  },
  render: function() {
    return (
      <a className="info-button button-xs" onClick={this.fetch}>
        <i className="fa fa-info"></i>
      </a>
    );
  }
});