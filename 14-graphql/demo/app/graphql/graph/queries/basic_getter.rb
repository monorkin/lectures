module Graph
  module Queries
    module BasicGetter
      def self.by_id(model:, type:)
        return_type = type
        GraphQL::Field.define do
          type(return_type)
          description("Find a #{model.name} by ID")
          argument(:id, !types.ID, "ID of the #{model.name}")
          resolve ->(obj, args, ctx) {
            model.find(args["id"])
          }
        end
      end

      def self.batch(model:, type:)
        return_type = type
        GraphQL::Field.define do
          type(return_type)
          argument(
            :page, types.Int,
            "Index of the page, by default only 10 elements are shown par page"
          )
          description("Return all #{model.name.pluralize}")
          resolve ->(obj, args, ctx) {
            model.all.page(args['page']).per(5)
          }
        end
      end
    end
  end
end
