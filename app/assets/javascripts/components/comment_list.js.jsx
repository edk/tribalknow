var CommentList = React.createClass( {
  render: function() {
    return (
      <div>
        {JSON.parse(this.props.comments).map(function(comment) {
          return <RestaurantComment key={comment.id} {... comment} />;
        })}
      </div>
    );
  }
});

