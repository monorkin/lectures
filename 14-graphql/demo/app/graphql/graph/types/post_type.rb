module Graph
  module Types
    PostType = GraphQL::ObjectType.define do
      name 'Post'
      description 'A blog post'
      field :id, !types.ID
      field :title, !types.String
      field :body, !types.String
      field :author, !AuthorType
      field :comments, types[!CommentType]
      field :comment_count, !types.Int
      field :created_at, !Scalars::DateTimeScalar
    end
  end
end
