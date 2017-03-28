module Graph
  module LazyExecutors
    class Single
      attr_reader :model_class
      attr_reader :query_ctx
      attr_reader :id
      attr_reader :lazy_state

      def initialize(model_class, query_ctx, id)
        @model_class = model_class
        @query_ctx = query_ctx
        @id = id

        @lazy_state = query_ctx[:lazy_find_product] ||= {
          pending_ids: Set.new,
          loaded_ids: {},
        }

        lazy_state[:pending_ids] << id
      end

      def resolve
        loaded_record = lazy_state[:loaded_ids][id]

        return loaded_record if loaded_record

        pending_ids = lazy_state[:pending_ids].to_a
        records = scope.where(id: pending_ids)
        records.each { |record| lazy_state[:loaded_ids][record.id] = record }
        lazy_state[:pending_ids].clear
        lazy_state[:loaded_ids][id]
      end

      private

      def scope
        model_class.all
      end
    end
  end
end
