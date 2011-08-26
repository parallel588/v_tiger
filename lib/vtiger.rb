require "vtiger/version"
require "vtiger/crud"
require "vtiger/query"

require 'httparty'
require 'json'
YAML::ENGINE.yamler = "syck"

require 'active_support/time'
require 'active_support/core_ext/numeric'
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/hash/slice'

class Vtiger
  cattr_accessor :user, :key, :uri
  include Vtiger::Crud
  include Vtiger::Query
  
  def self.config(config = {})
    Vtiger.user = config[:user]
    Vtiger.key  = config[:key]
    Vtiger.uri  = config[:uri]
  end
  
  def list_types
    get('listtypes')['result']['types']
  end

  def describe(element_type)
    get('describe', :elementType => element_type)['result']
  end
  
  def get(operation, query = {})
    query = {:operation => operation, :sessionName => Vtiger.session}.merge(query)
    HTTParty.get(Vtiger.uri, :query => query).parsed_response
  end
  
  def post(operation, body = {})
    body = {:operation => operation, :sessionName => Vtiger.session}.merge(body)
    HTTParty.post(Vtiger.uri, :body => body).parsed_response
  end
  
  private
  
    def self.session
      unless @session && @challenge['expireTime'] > 30.seconds.from_now.to_i
        @challenge  = HTTParty.get(uri, :query => {:operation => 'getchallenge', :username => user}).parsed_response['result']
        digest      = "#{@challenge['token']}#{key}"
        access_key  = Digest::MD5.hexdigest(digest)
        @session    = HTTParty.post(uri, {:body => {:operation => 'login', :username => user, :accessKey => access_key}}).parsed_response['result']['sessionName']
      end
      @session
    end
end