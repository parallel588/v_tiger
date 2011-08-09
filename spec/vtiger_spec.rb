require 'spec_helper'

describe "Vtiger" do
  describe ".config" do
    before(:all) do 
      Vtiger.config(:user => 'admin', :key  => 'dH1WLzo4utYOpXx9', :uri  => 'http://crm.ihswebdesign.com/webservice.php')
    end
    context "should set user, key, and uri class variables" do
      it "user is admin" do
        Vtiger.user.should == 'admin'
      end
      
      it "key is dH1WLzo4utYOpXx9" do
        Vtiger.key.should == 'dH1WLzo4utYOpXx9'
      end
      
      it "uri is http://crm.ihswebdesign.com/webservice.php" do
        Vtiger.uri.should == 'http://crm.ihswebdesign.com/webservice.php'
      end
    end
  end
  
  before(:all) do
     Vtiger.config(:user => 'admin', :key  => 'dH1WLzo4utYOpXx9', :uri  => 'http://crm.ihswebdesign.com/webservice.php')
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
      Vtiger.class_eval{session}.should be
    end
    
    it "should persist" do
      Vtiger.class_eval{session}.should == Vtiger.class_eval{session}
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