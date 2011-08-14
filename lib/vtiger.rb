require "vtiger/version"
require "vtiger/api"
# require 'vt/attribute_accessors'
require 'HTTParty'
require 'active_support/time'
require 'active_support/core_ext/numeric'
require 'active_support/core_ext/class/attribute_accessors'


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
    
    def list_types
      api_get('listtypes')['types']
    end

    def describe(element_type)
      api_get('describe', {:elementType => element_type})
    end
    
    private
    def session
      unless @session && @challenge['expireTime'] > 30.seconds.from_now.to_i
        @challenge  = get(uri, :query => {:operation => 'getchallenge', :username => user})
        digest      = "#{@challenge['token']}#{key}"
        access_key  = Digest::MD5.hexdigest(digest)
        @session    = post(uri, {:body => {:operation => 'login', :username => user, :accessKey => access_key}})['sessionName']
      end
      @session
    end

    def get(*args)
      super(*args).parsed_response['result']
    end

    def api_get(operation, query = {})
      query = {:operation => operation, :sessionName => session}.merge(query)
      get(uri, :query => query)
    end

    def post(*args)
      super(*args).parsed_response['result']
    end
  end
  extend Vtiger::ClassMethods
end