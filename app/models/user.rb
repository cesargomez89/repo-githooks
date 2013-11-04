require 'net/http'
require 'uri'
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
    :recoverable, :rememberable, :trackable, :validatable

  def self.build_from_omniauth auth
    find_or_initialize_by(
      uid:      auth['uid'],
      provider: auth['provider'],
      username: auth['info']['nickname']
    )
  end

  def self.create_url
    hook = {
      "name"=> "web",
      "active"=> true,
      "events"=> [ "push", "pull_request" ],
      "config"=> {
        "url"=> "http://example.com/webhook",
        "content_type"=> "json"
      }
    }
    uri = URI('https://api.github.com/repos/cesargomez89/sidekiq-jobs/hooks')

    request = Net::HTTP::Post.new(uri.path)
    request.body = hook.to_s
    request["content-type"] = "application/json"
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      binding.pry
      puts response = http.request(request)
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end
