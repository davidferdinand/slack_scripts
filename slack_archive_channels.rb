require 'httparty'
require 'json'
require_relative "./slack_channels"

SLACK_TOKEN = ENV["SLACK_TOKEN"]

$channels.each do | chan |
  channel_id = chan

  response = HTTParty.post(
    "https://slack.com/api/channels.archive?token=#{SLACK_TOKEN}&channel=#{channel_id}&pretty=1",
    headers: {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
  )

  puts response.body
  # to not breach slack API limits, the sleep is needed
  sleep(1)
end
