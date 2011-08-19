require 'spec_helper'

describe "Vtiger::API" do
  before(:all) do 
    Vtiger.config(:user => 'admin', :key  => 'dH1WLzo4utYOpXx9', :uri  => 'http://crm.ihswebdesign.com/webservice.php')
    @api = Vtiger::API.new
  end
  describe "#create" do
    context " with a valid object" do
      it "should return success" do
        @api.create('Products', 'productname' => 'Title of Product', 'manufacture' => 'Broyhill')['success'].should be_true
      end
    
      it "should return an VtigerObject that matches what we sent" do
        attributes = {'productname' => 'Title of Product', 'manufacturer' => 'Broyhill'}
        @api.create('Products', attributes)['result'].should include_hash(attributes)
      end
    end
  end
  
  describe "#list_types" do
    it "should include Products" do
      @api.list_types.should include('Products')
    end
  end
  
  describe "#describe" do
    context " Product" do
      it "should have a label with Products" do
        @api.describe('Products')['label'].should == "Products"
      end
    end
    
  end
end