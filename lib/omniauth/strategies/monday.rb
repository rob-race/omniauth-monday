require "omniauth-oauth2"
require "graphql/client"
require "graphql/client/http"

module OmniAuth
  module Strategies
    class Monday < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: "https://api.monday.com/v2",
        authorize_url: "https://auth.monday.com/oauth2/authorize",
        token_url: "https://auth.monday.com/oauth2/token",
        response_type: "code"
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { me["id"] }

      extra do
        { raw_info: raw_info, me: me }
      end

      def raw_info
        @raw_info ||= {}
      end

      def me
        @me ||= begin
          http = GraphQL::Client::HTTP.new(options.client_options.site) do |obj|
            def headers(context)
              {"Authorization" => "Bearer #{context[:token]}"}
            end
          end
          schema = GraphQL::Client.load_schema(http)
          client = GraphQL::Client.new(schema: schema, execute: http)
          client.allow_dynamic_queries = true

          gql = client.parse <<~GRAPHQL
            query {
              me {
              email
              name
              id
            }
            }
          GRAPHQL
          response = client.query(gql, context: {token: access_token.token})
          response.data.to_h
        end
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization "monday", "Monday"