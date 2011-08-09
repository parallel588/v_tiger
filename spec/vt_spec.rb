require 'spec_helper'

describe "VT" do
  before(:all) do
    Vtiger.user = 'admin'
    Vtiger.key  = 'dH1WLzo4utYOpXx9'
    Vtiger.uri  = 'http://crm.ihswebdesign.com/webservice.php'
    # http://c-fastest.com/vtiger/webservice.php
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
      Vtiger.session.should be
    end
    
    it "should persist" do
      Vtiger.session.should == Vtiger.session
    end
  end
  
  describe ".list_types" do
    it "should include Products" do
      Vtiger.list_types.should include('Products')
    end
  end
  
  describe ".describe" do
    context " Product" do
      it "should have a label with Products" do
        Vtiger.describe('Products')['label'].should == "Products"
      end
    end
    
  end
end