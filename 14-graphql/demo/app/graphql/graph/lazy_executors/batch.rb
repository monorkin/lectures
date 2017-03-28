module Graph
  module LazyExecutors
    class Batch
      attr_reader :model_class
      attr_reader :query_ctx
      attr_reader :ids
      attr_reader :lazy_state
      attr_reader :scope

      def initialize(model_class, query_ctx, ids, scope: nil)
        @model_class = model_class
        @query_ctx = query_ctx
        @ids = Array(ids)
        @scope = scope

        @lazy_state = query_ctx[:lazy_find_product] ||= {
          pending_ids: Set.new,
          loaded_ids: {}
        }

        lazy_state[:pending_ids].merge(ids)
      end

      def resolve
        loaded_records = lazy_state[:loaded_ids].slice(*ids).values

        return loaded_records if loaded_records.count == ids.count

        pending_ids = lazy_state[:pending_ids].to_a
        records = scope.where(id: pending_ids)
        records.each { |record| lazy_state[:loaded_ids][record.id] = record }
        lazy_state[:pending_ids].clear
        lazy_state[:loaded_ids].slice(*ids).values
      end

      private

      def scope
        @scope ||= model_class.all
      end
    end
  end
end
