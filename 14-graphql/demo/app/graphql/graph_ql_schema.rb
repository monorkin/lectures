GraphQlSchema = GraphQL::Schema.define do
  query Graph::Types::QueryType
  mutation Graph::Types::MutationType

  lazy_resolve(Graph::LazyExecutors::Single, :resolve)
  lazy_resolve(Graph::LazyExecutors::Batch, :resolve)
end
