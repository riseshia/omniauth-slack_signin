require "omniauth/strategies/oauth2"
require "uri"
require "rack/utils"

module OmniAuth
  module Strategies
    class SlackSignin < OmniAuth::Strategies::OAuth2
      option :name, "slack_signin"

      option :authorize_options, [:scope, :team]

      option :client_options, {
        site: "https://slack.com",
        token_url: "/api/oauth.access"
      }

      option :auth_token_params, {
        mode: :query,
        param_name: "token"
      }

      uid { raw_info["user"]["id"] }

      info do
        {
          team: team_info,
          user: user_info
        }
      end

      def user_info
        return nil if raw_info["user"].nil?
        {
          id: raw_info["user"]["id"],
          name: raw_info["user"]["name"],
          email: raw_info["user"]["email"],
          image_24: raw_info["user"]["image_24"],
          image_32: raw_info["user"]["image_32"],
          image_48: raw_info["user"]["image_48"],
          image_72: raw_info["user"]["image_72"],
          image_192: raw_info["user"]["image_192"],
          image_512: raw_info["user"]["image_512"]
        }
      end

      def team_info
        return nil if raw_info["user"].nil?
        {
          id: raw_info["team"]["id"],
          name: raw_info["team"]["name"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/api/users.identity").parsed
      end

      def authorize_params
        super.tap do |params|
          %w[scope team].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end
    end
  end
end
