require "vtiger/version"
require "vtiger/api"

require 'httparty'
require 'json'
YAML::ENGINE.yamler = "syck"

require 'active_support/time'
require 'active_support/core_ext/numeric'
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/hash/slice'

class Vtiger
  cattr_accessor :user, :key, :uri
  include HTTParty
  format :json
  
  module ClassMethods
    def config(config = {})
      Vtiger.user = config[:user]
      Vtiger.key  = config[:key]
      Vtiger.uri  = config[:uri]
    end
    
    def session
      unless @session && @challenge['expireTime'] > 30.seconds.from_now.to_i
        @challenge  = get(uri, :query => {:operation => 'getchallenge', :username => user})['result']
        digest      = "#{@challenge['token']}#{key}"
        access_key  = Digest::MD5.hexdigest(digest)
        @session    = post(uri, {:body => {:operation => 'login', :username => user, :accessKey => access_key}})['result']['sessionName']
      end
      @session
    end

    def get(*args)
      super(*args).parsed_response
    end

    def post(*args)
      super(*args).parsed_response
    end
  end
  extend Vtiger::ClassMethods
end