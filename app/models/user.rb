class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
    :recoverable, :rememberable, :trackable, :validatable

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        username: auth.info.nickname,
        email:    auth.info.email,
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"]
        user.email = data.info.email if user.email.blank?
      end
    end
  end

  #def self.create_url
  #  hook = {
  #    "name"=> "web",
  #    "active"=> true,
  #    "events"=> [ "push", "pull_request" ],
  #    "config"=> {
  #      "url"=> "http://example.com/webhook",
  #      "content_type"=> "json"
  #    }
  #  }
  #  uri = URI('https://api.github.com/repos/cesargomez89/sidekiq-jobs/hooks')

  #  request = Net::HTTP::Post.new(uri.path)
  #  request.body = hook.to_s
  #  request["content-type"] = "application/json"
  #  Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
  #    binding.pry
  #    puts response = http.request(request)
  #  end
  #end

  #def password_required?
  #  super && provider.blank?
  #end

  #def update_with_password(params, *options)
  #  if encrypted_password.blank?
  #    update_attributes(params, *options)
  #  else
  #    super
  #  end


  def self.git_hook
    hook = {
      "name"=> "web",
      "active"=> true,
      "events"=> [ "push", "pull_request" ],
      "config"=> {
        "url"=> "http://example.com/webhook",
        "content_type"=> "json"
      }
    }
    options = { :body => hook }
    response = HTTParty.post('https://api.github.com/repos/cesargomez89/sidekiq-jobs/hooks', options)
  end

end
