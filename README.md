# Project 2

This is a test

## Description
Challenge yourself or your friends to give up a vice, and bet on your success. I bet $100, I can give up cheese for 5 days.

## Models

# User
*  phone_number
*  first_name
*  last_name
*  password_digest
*  img_url
*email

### Challenge
*  title
*  start_date
*  end_date
*  category
*  challenge_value
*  objective
*  failure_penalty_text
*  status - success, fail, done


### Message
*  text
*  is_private
*  is_caught
*  is_confirmed
*  img_url

### User_challenge
*  user_id
*  role
*  balance
*  challenge_success
*  video url
*  challenge_id
*  message_id

### Roles
*  Organizer - has admin rights to add videos, start/end challenge, could be challenger also
*  Challenger - the one doing the abstaining
*  Supporters - share the initial pot to give to charity, keep the challenger on track

## API's used:
*  Twilio
*  FirstGiving
*  Amazon S3?
*  D3?



