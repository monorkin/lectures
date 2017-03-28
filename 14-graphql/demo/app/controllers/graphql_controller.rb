class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    query_string = params[:graphql][:query]
    variables = params[:graphql][:variables].try(:to_unsafe_hash)
    context = {
      # current_user: current_user
    }

    graphql_response = GraphQlSchema.execute(
      query_string,
      variables: variables,
      context: context
    )

    render json: graphql_response
  end
end
