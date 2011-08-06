require "vt/version"
# require 'vt/attribute_accessors'
require 'HTTParty'


class VT
  cattr_accessor :user, :key, :uri
  include HTTParty
  default_params :output => 'json'
  format :json
  
  def self.list_types
    result(get(uri, :query => {:operation => 'listtypes', :sessionName => session}))
  end
      
  protected
  def self.session
    unless @session && @challenge['expireTime'] < 30.seconds.from_now.to_i
      @challenge  = result(get(uri, :query => {:operation => 'getchallenge', :username => user}))
      digest     = "#{@challenge['token']}#{key}"
      access_key = Digest::MD5.hexdigest(digest)
      @session   = result(VT.post(uri, {:body => {:operation => 'login', :username => user, :accessKey => access_key}}))['sessionName']\
    end
    @session
  end
  
  private
  def self.result(query)
    if query['success']
      query.parsed_response['result']
    else
      raise "query failed"
    end
  end
end