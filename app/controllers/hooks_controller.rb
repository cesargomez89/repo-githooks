class HooksController < ApplicationController
  def github
    user = User.create(
      uid:      Random.new.rand(1..1000000).to_s,
      provider: 'github',
      username: Faker::Internet.email,
      email:    Faker::Internet.user_name,
      password: '12345678'
    )
    if user.presisted?
      redirect_to :root
    end
  end

  def hook_params
    params.require(:payload)
  end
end
