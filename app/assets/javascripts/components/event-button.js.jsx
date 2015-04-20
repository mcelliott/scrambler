var EventButton = React.createClass({
  edit: function() {
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
      <a href='#' className="event-button button-xs" onClick={this.edit}>
        <i className={"fa fa-" + this.props.icon}></i>
        &nbsp;{this.props.text}
      </a>
    );
  }
});
