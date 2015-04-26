var DeleteButton = React.createClass({
  destroy: function() {
    var item = $('#' + this.props.item);
    $.ajax({
      type: 'DELETE',
      url: this.props.path,
      dataType: 'script',
      success: function (data) {
        item.slideToggle("slow");
      }
    }).fail(function(xhr, status, err) {
      console.error(this.props.path, status, err.toString());
    });
  },
  render: function() {
    var msg = '{"body":"' + this.props.confirm + '"}';
    return (
      <a href='#' className="action-button button" onClick={this.destroy} data-confirm={msg}>
        <i className="fa fa-trash"></i>
      </a>
    );
  }
});
