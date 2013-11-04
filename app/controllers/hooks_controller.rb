require 'faker'
class HooksController < ApplicationController

  def github
   user = User.new(
      uid:      Random.new.rand(1..1000000).to_s,
      provider: 'github',
      email:    Faker::Internet.email,
      username: Faker::Internet.user_name,
      password: '12345678'
    )
    respond_to do |format|
      if user.save
        format.json { render json: { message: 'successfully added user' }, status: :ok }
      else
        format.json { render json: { message: 'You cannot create the user' }, status: :unprocessable_entity }
      end
    end
  end

  def hook_params
    params.require(:payload)
  end
end
