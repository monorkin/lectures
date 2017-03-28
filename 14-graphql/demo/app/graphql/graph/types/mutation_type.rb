module Graph
  module Types
    MutationType = GraphQL::ObjectType.define do
      name 'Mutation'
      description 'The mutation root of this schema'

      field :createComment, field: Mutations::CreateCommentMutation.field
    end
  end
end
