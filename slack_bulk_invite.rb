require 'httparty'
require 'json'
require_relative "./slack_emails"

SLACK_TOKEN = ENV["SLACK_TOKEN"]
SLACK_USERS = "https://slack.com/api/users.list?token=#{SLACK_TOKEN}&pretty=1"

# enter the channel ID of the channel you are inviting users too
channel_id = "channel_ID"

  response = HTTParty.get(
    SLACK_USERS,
    headers: {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
  )

  data = response.body
  parsed = JSON.parse(data)

  parsed["members"].each do |members|
    if members["deleted"] == false
      if members["is_restricted"] == false
        if members["profile"]["email"]
          if !$emails.include? members["profile"]["email"].downcase
            user_id = members["id"]

            response = HTTParty.post(
              "https://slack.com/api/channels.invite?token=#{SLACK_TOKEN}&channel=#{channel_id}&user=#{user_id}&pretty=1",
              headers: {
                'Content-Type' => 'application/x-www-form-urlencoded'
              }
            )

            rs = JSON.parse(response.body)
            if rs["ok"] == true
              puts "invited " + members["profile"]["email"]
              sleep(1)
            else
              puts members["profile"]["email"] + " " + rs["error"]
              sleep(1)
            end
          end
        end
      end
    end
  end
