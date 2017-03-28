module Graph
  module Types
    CommentType = GraphQL::ObjectType.define do
      name 'Comment'
      field :id, !types.ID
      field :body, !types.String
      field :post, !PostType
      field :author, !AuthorType
      field :created_at, !Scalars::DateTimeScalar
    end
  end
end
