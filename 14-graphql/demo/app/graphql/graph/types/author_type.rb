module Graph
  module Types
    AuthorType = GraphQL::ObjectType.define do
      name 'Author'
      field :id, !types.ID
      field :first_name, !types.String
      field :last_name, !types.String
      field :full_name, !types.String
      field :posts, types[!PostType]
      field :comments, types[!CommentType]
    end
  end
end
