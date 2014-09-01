

  desc 'Load fake data for development/testing.'
  task :faker => ['db:setup', 'fake:users', 'fake:messages', 'fake:challenges', 'fake:userchallenges']

  NUM_MESSAGES = 10
  NUM_CHALLENGES = 6
  NUM_USERS = 6
  START_DATE = DateTime.now - 2.weeks
  END_DATE = DateTime.now + 2.weeks
  STATUSES = ["success", "fail", "open", "done"]
  ROLES = ["challenger", "supporter"]

  namespace :fake do
    require 'ffaker'
    require 'populator'

    # add password/password_confirmation to this when using auth
    desc 'Create some fake users'
    task :users => :environment do
      User.populate NUM_USERS do |u|
        u.first_name = Faker::Name.first_name
        u.last_name = Faker::Name.last_name
        u.email = Faker::Internet.disposable_email('johndoe')
        u.phone_number = '+1' + Faker::PhoneNumber.short_phone_number.delete('-')
      end
    end

    desc 'Create some fake messages'
    task :messages => :environment do
      Message.populate NUM_MESSAGES do |m|
        m.is_private = Faker::Boolean.maybe
        m.is_caught = Faker::Boolean.maybe
        m.is_confirmed = Faker::Boolean.maybe
        m.is_invitation = Faker::Boolean.maybe
        m.user_id = rand(6) + 1
        m.challenge_id = rand(6) + 1
        m.text = Faker::HipsterIpsum.paragraph(sentence_count=1)
      end
    end

    desc 'Create some fake challenges'
    task :challenges => :environment do
      Challenge.populate NUM_CHALLENGES do |c|
        c.start_date = START_DATE
        c.end_date = END_DATE
        c.category = Faker::HipsterIpsum.word
        c.challenge_amount = rand(100) + 1
        c.charity_id = ''
        c.status = STATUSES.sample
        c.title = Faker::HipsterIpsum.sentence(word_count=3)
      end
    end


    desc 'Create many to many associations'
    task :userchallenges => :environment do
      UserChallenge.populate NUM_CHALLENGES do |u_c|
        u_c.user_id = rand(6) + 1
        u_c.challenge_id = rand(6) + 1
        u_c.role = ROLES.sample
        u_c.is_accepted = Faker::Boolean.maybe
        u_c.balance = rand(100) + 1
      end
    end

  end







