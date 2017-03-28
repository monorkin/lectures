module Graph
  module Scalars
    DateTimeScalar = GraphQL::ScalarType.define do
      name 'DateTime'
      description 'ISO 8601 date-time representation'
      coerce_input -> (value) do
        Time.parse(value)
      end
      coerce_result -> (value) do
        value.iso8601
      end
    end
  end
end
