class HooksController < ApplicationController
  def github
    User.create(
      uid:      Random.new.rand(1..1000000).to_s,
      provider: 'github',
      username: Faker::Internet.email,
      email:    Faker::Internet.user_name,
      password: '12345678'
    )
  end
end
