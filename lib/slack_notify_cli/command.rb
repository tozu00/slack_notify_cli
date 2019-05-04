require 'thor'
require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

module SlackNotifyCli
  class Command < Thor
    desc "slack_notify_cli auth_check", "auth check"
    def auth_check
      client = Slack::Web::Client.new
      puts client.auth_test['ok'] ? "Authentication successed" : "Authentication failed"
    end

    desc "slack_notify_cli channel_list", "get channel list"
    def channel_list
      client = Slack::Web::Client.new
      channels = client.channels_list.channels
      puts channels.map { |c| "##{c.name} #{c.purpose.value}"}
    end

    desc "slack_cli send str:{channel} str:{message}", "send message ex.) slack_cli send \"#general\" \"Hello World\""
    def send(channel, message)
      client = Slack::Web::Client.new
      client.chat_postMessage(channel: channel, text: message, as_user: true)
    end
  end
end
