# Omniauth::SlackSignin

This Gem contains the Signin with Slack strategy for OmniAuth.

We already have [good strategy for slack](https://github.com/kmrshntr/omniauth-slack), however, this gem is not work well.

In addition, if we want to implement that, we need to be blind. Meaning to say, we should assume `identify.basic` scope is applied or not by returned params. One more thing. Maybe some clever developer handle this problem in the future, but I can't bear to retrieve user name with `auth.info.nickname.name` with `identify` scope. lol.

so this gem only support about Sign-In feature with Slack. If you want another api, then just go [origin gem](https://github.com/kmrshntr/omniauth-slack) and use it. It is not hard as you know, isn't it?

## How to use

First start by adding this gem to your Gemfile:

```ruby
gem 'omniauth-slack_signin', github: 'riseshia/omniauth-slack_signin'
```

Next, tell OmniAuth about this provider. For a Rails app, your `config/initializers/omniauth.rb` file should look like this:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack_signin, "AUTH_KEY", "AUTH_SECRET", scope: "identity:basic"
end
```

Replace `"AUTH_KEY"` and `"AUTH_SECRET"` with the appropriate values you obtained from [weirdx](not yet).

If you are using [Devise](https://github.com/plataformatec/devise) then it will look like this:

```ruby
Devise.setup do |config|
  # ...
  config.omniauth :slack, ENV["AUTH_KEY"], ENV["AUTH_SECRET"], scope: 'identity:basic'
  # ...
end
```

## About API

Follow this [link](https://api.slack.com/methods/users.identity).
