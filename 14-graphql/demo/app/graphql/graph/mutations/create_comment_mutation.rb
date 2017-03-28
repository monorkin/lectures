module Graph
  module Mutations
    CreateCommentMutation = GraphQL::Relay::Mutation.define do
      name 'CreateComment'

      input_field :postId, !types.ID
      input_field :authorId, !types.ID
      input_field :body, !types.String

      return_field :post, Types::PostType
      return_field :comment, Types::CommentType

      resolve -> (object, inputs, ctx) {
        post = Post.find(inputs[:postId])
        comment = post.comments.create!(
          author_id: inputs[:authorId], body: inputs[:body]
        )

        {
          comment: comment,
          post: post,
        }
      }
    end
  end
end
