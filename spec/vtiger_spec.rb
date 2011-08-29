require 'spec_helper'

describe "VTiger" do
  before(:all) do 
    VTiger.config(:user => 'admin', :key  => 'dH1WLzo4utYOpXx9', :uri  => 'http://crm.ihswebdesign.com/webservice.php')
    @api = VTiger.new
  end
  describe ".config" do
    context "should set user, key, and uri class variables" do
      it "user is admin" do
        VTiger.user.should == 'admin'
      end
      
      it "key is dH1WLzo4utYOpXx9" do
        VTiger.key.should == 'dH1WLzo4utYOpXx9'
      end
      
      it "uri is http://crm.ihswebdesign.com/webservice.php" do
        VTiger.uri.should == 'http://crm.ihswebdesign.com/webservice.php'
      end
    end
  end

  describe "#create" do
    context " with a valid object" do
      before(:all) do
        @attributes = {'productname' => 'Title of Product', 'manufacturer' => 'Broyhill'}
        @create = @api.create('Products', @attributes)
      end
      it "should return success" do
        @create['success'].should be_true
      end
    
      it "should return an VTigerObject that matches what we sent" do
        @create['result'].should include_hash(@attributes)
      end
    end
  end
  
  describe "#retrieve" do
    context " with a valid object" do
      before(:all) do
        @attributes = {'productname' => 'Title of Product', 'manufacturer' => 'Broyhill'}
        id = @api.create('Products', @attributes)['result']['id']
        @retrieve = @api.retrieve(id)
      end
      it "should return success" do
        @retrieve['success'].should be_true
      end
    
      it "should return an VTigerObject that matches what we sent" do
        @retrieve['result'].should include_hash(@attributes)
      end
    end
  end
  
  describe "#query" do
    before(:all) do
      @query = @api.query('select * from Products;')
    end
    it "should return success" do
      @query['success'].should be_true
    end
    
    it "should return an array of objects" do
      @query['result'].should be_a(Array)
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
  
  describe ".session" do
    it "should be present" do
      VTiger.class_eval{session}.should be
    end
    
    it "should persist" do
      VTiger.class_eval{session}.should == VTiger.class_eval{session}
    end
  end
end