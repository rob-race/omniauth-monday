require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Monday < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: "https://api.monday.com/v2",
        authorize_url: "https://auth.monday.com/oauth2/authorize",
        token_url: "https://auth.monday.com/oauth2/token",
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[client_options].each do |v|
            params[v.to_sym] = request.params[v] if request.params[v]
          end
        end
      end

      uid { me["id"] }

      extra do
        { raw_info: me }
      end

      def raw_info
        @raw_info ||= {}
      end

      def me
        @me ||= begin
          access_token.options[:mode] = :header
          response = access_token.post("", body: { query: query }).parsed
          response["data"]["me"].merge("account_id": response["account_id"])
        end
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def query
        <<~GRAPHQL
          query {
            me {
            email
            name
            id
          }
          }
        GRAPHQL
      end
    end
  end
end

OmniAuth.config.add_camelization "monday", "Monday"
