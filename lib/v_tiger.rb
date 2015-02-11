require "v_tiger/version"
require "v_tiger/api"
#require "v_tiger/query"

require 'httparty'
require 'json'
YAML::ENGINE.yamler = "syck"

require 'active_support'
require 'active_support/time'
require 'active_support/core_ext/numeric'
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/hash/slice'

class VTiger
  cattr_accessor :user, :key, :uri, :logging
  include VTiger::API
  # include VTiger::Query

  def self.config(config = {})
    VTiger.user     = config[:user]
    VTiger.key      = config[:key]
    VTiger.uri      = config[:uri]
    VTiger.logging  = config[:logging]
  end

  def get(operation, query = {})
    query = {:operation => operation, :sessionName => VTiger.session}.merge(query)
    response = HTTParty.get(VTiger.uri, :query => query)
    log(response) if VTiger.logging
    response.parsed_response
  end

  def post(operation, body = {})
    body = {:operation => operation, :sessionName => VTiger.session}.merge(body)
    response = HTTParty.post(VTiger.uri, :body => body)
    log(response) if VTiger.logging
    response.parsed_response
  end

  def log(response)
    puts "URI: #{response.request.uri.to_s}"
    puts "BODY: #{response.body}"
    puts ''
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