var RestaurantComment = React.createClass( {
  propTypes: {
    author: React.PropTypes.string,
    body: React.PropTypes.string,
    rank: React.PropTypes.number
  },

  render: function () {
    return (
      <div>
        <div> Author: {this.props.author}</div>
        <div> body: {this.props.body}</div>
        <div> rank: {this.props.rank}</div>
      </div>
    );
  }
});
