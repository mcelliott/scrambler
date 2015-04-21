var DeleteButton = React.createClass({
  destroy: function() {
    $.ajax({
      type: 'DELETE',
      url: this.props.path,
      dataType: 'script',
      success: function (data) {
        $('#' + this.props.item).slideToggle("slow", function(){});
      }
    }).fail(function(xhr, status, err) {
      console.error(this.props.path, status, err.toString());
    });
  },
  render: function() {
    var msg = '{"body":"' + this.props.confirm + '"}';
    return (
      <a href='#' className="delete-button button" onClick={this.destroy} data-confirm={msg}>
        <i className="fa fa-trash"></i>
      </a>
    );
  }
});
