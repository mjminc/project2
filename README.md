# Project 2

## To populate the db with ffaker stuff

*  disconnect from pg commander and stop
*  rails server
*  run rake db:reset
*  run rake fake:users
*  run rake fake:messages
*  run rake fake:challenges


## Description
Challenge yourself or your friends to give up a vice, and bet on your success. I bet $100, I can give up cheese for 5 days.

## Models

# User
*  phone_number
*  first_name
*  last_name
*  password_digest
*  img_url
*  email

User has_many messages
User has_many challenges through User_challenges

### Challenge
*  title
*  start_date
*  end_date
*  category
*  challenge_value
*  charity_id
*  failure_penalty_text
*  status - success, fail, open, done

Challenge has_many users through User_challenge
Challenge has many messages


### Message
*  text
*  is_private
*  is_caught
*  is_confirmed
*  img_url
*  user_id
*  challenge_id
*  is_invitation

Message Belongs to User
Message Belongs to Challenge

### User_challenge
*  user_id
*  role - challenger, supporter
*  accepted
*  balance
*  challenge_success
*  video url
*  challenge_id

User_challenge belongs to User
User_challenge belongs to Challenge

### Roles
*  Organizer - has admin rights to add videos, start/end challenge, could be challenger also
*  Challenger - the one doing the abstaining
*  Supporters - share the initial pot to give to charity, keep the challenger on track

## API's used:
*  Twilio
*  FirstGiving
*  Amazon S3?
*  D3?



