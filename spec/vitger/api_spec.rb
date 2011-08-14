require 'spec_helper'

describe "Vtiger::API" do
  before(:all) do 
    Vtiger.config(:user => 'admin', :key  => 'dH1WLzo4utYOpXx9', :uri  => 'http://crm.ihswebdesign.com/webservice.php')
  end
  describe "#create" do
    it "should accept a elemnetType and hash of attributes" do
      api = Vitger::API.new
      api.create('Products', 'productname' => 'Title of Product', 'manufacture' => 'Broyhill')
    end
  end
end