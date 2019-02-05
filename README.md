# Slack Scripts

### Requirements

Ruby 2.4.x  
Slack token saved as environment variable `SLACK_TOKEN`

___

### Scripts

#### [slack_archive_channels](./slack_archive_channels.rb)
The script takes the channel IDs from `slack_channels.rb`.  
These are then parsed to the slack API to archive the channels.


#### [slack_bulk_invite](./slack_bulk_invite.rb)
The script fetches data for all users in the slack account.  
It then compares this against the list in `slack_emails.rb`.

- If the address is in the list it takes no further action with that user.  
- If the address is not in the list, it will invite the user to the channel.  

The `channel_id` is set on line 9 of the script.  
It logs the success of each invite to standard out.

___

### How to run

Run `bundle install`  
Add emails or channel IDs to the relevant files.  
Run the scripts `ruby slack_bulk_invite.rb` or `ruby slack_archive_channels.rb`.  
As the scripts have wait times, they can take several minutes to complete, so grab a cup of tea and relax.
