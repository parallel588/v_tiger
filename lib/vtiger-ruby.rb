require "vt/version"
# require 'vt/attribute_accessors'
require 'HTTParty'
require 'active_support/time'
require 'active_support/core_ext/numeric'
require 'active_support/core_ext/class/attribute_accessors'


class VT
  cattr_accessor :user, :key, :uri
  include HTTParty
  format :json

  
  def self.list_types
    api_get('listtypes')
  end
      
  protected
  def self.session
    unless @session && @challenge['expireTime'] > 30.seconds.from_now.to_i
      @challenge  = get(uri, :query => {:operation => 'getchallenge', :username => user})
      digest      = "#{@challenge['token']}#{key}"
      access_key  = Digest::MD5.hexdigest(digest)
      @session    = post(uri, {:body => {:operation => 'login', :username => user, :accessKey => access_key}})['sessionName']
    end
    @session
  end
  
  def self.get(*args)
    puts *args.inspect
    super(*args).parsed_response['result']
  end
  
  def self.api_get(operation)
    get(uri, :query => {:operation => operation, :sessionName => session })
  end
  
  def self.post(*args)
    super(*args).parsed_response['result']
  end
end