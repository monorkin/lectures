module Graph
  module Types
    QueryType = GraphQL::ObjectType.define do
      name 'Query'
      description 'The query root of this schema'

      # Individual getters
      field :post, PostType,
            field: Queries::BasicGetter.by_id(type: PostType, model: Post)
      field :author, AuthorType,
            field: Queries::BasicGetter.by_id(type: AuthorType, model: Author)
      field :comment, CommentType,
            field: Queries::BasicGetter.by_id(type: CommentType, model: Comment)

      # Batch getters
      field :authors, types[!AuthorType],
            field: Queries::BasicGetter.batch(
              type: types[!AuthorType],
              model: Author
            )
      field :comments, types[!CommentType], field: Queries::CommentsQuery
      field :posts, types[!PostType],
            field: Queries::BasicGetter.batch(
              type: types[!PostType],
              model: Post
            )
    end
  end
end
