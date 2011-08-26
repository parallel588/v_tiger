require 'spec_helper'

describe "Vtiger::Query" do
  before(:all) do 
    Vtiger.config(:user => 'admin', :key  => 'dH1WLzo4utYOpXx9', :uri  => 'http://crm.ihswebdesign.com/webservice.php')
    @api = Vtiger.new
  end
  describe "#query" do
    it "should return somthing" do
      @api.query('Products', :fields => ['productname', 'manufacturer'], :where => ['discontinued is false'])['result'].should be
    end
    
  end
end