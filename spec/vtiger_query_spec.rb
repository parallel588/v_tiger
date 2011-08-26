require 'spec_helper'

describe "Vtiger::Query" do
  before(:all) do 
    Vtiger.config(:user => 'admin', :key  => 'dH1WLzo4utYOpXx9', :uri  => 'http://crm.ihswebdesign.com/webservice.php')
    @api = Vtiger.new
  end
  describe "#query" do
    context "with just the objectType " do
      before(:all) do
        @query = @api.query('Products')
      end
      it "should return somthing" do
        @query['result'].should be
      end
      
      it "should default to 100 objects" do
        @query['result'].count.should equal(100)
      end
    end
    
    context "with a limit" do
      it "should not return more than the limit" do
        @api.query('Products', :limit => 50)['result'].count.should_not > 50
      end
      
      it "should return more than 100 is more than default" do
        @api.query('Products', :limit => 150)['result'].count.should > 100
      end
    end
  end
end