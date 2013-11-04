class WelcomeController < ApplicationController
  def git_hook
    @response = User.git_hook
    binding.pry
  end
end
