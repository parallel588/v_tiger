require 'spec_helper'

describe "VT" do
  before(:all) do
    VT.user = 'admin'
    VT.key  = 'dH1WLzo4utYOpXx9'
    VT.uri  = 'http://crm.ihswebdesign.com/webservice.php'
  end
  
  # describe ".get_challenge" do
  #   describe ":token" do
  #     it "should be present" do
  #       VT.get_challenge['token'].should be
  #     end
  #   end
  # end
  
  describe ".session" do
    it "should be present" do
      VT.session.should be
    end
    
    it "should persist" do
      VT.session.should == VT.session
    end
  end
  
  describe ".list_types" do
    it "should include Products" do
      VT.list_types['types'].should include('Products')
    end
  end
end