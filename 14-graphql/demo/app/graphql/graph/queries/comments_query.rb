module Graph
  module Queries
    CommentsQuery = GraphQL::Field.define do
      type(types[!Types::CommentType])
      argument(
        :page, types.Int,
        "Index of the page, by default only 10 elements are shown par page"
      )
      argument(:postId, types.ID, "Id of the post the comment belongs to")
      description("Return all comments")
      resolve ->(obj, args, ctx) {
        scope = Comment.all
        if args['postId'].present?
          post = Post.find(args['postId'])
          scope = scope.where(post: post)
        end
        scope.page(args['page']).per(10)
      }
    end
  end
end
