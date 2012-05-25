require 'spec_helper'

module Preppers

  describe Clone do
    
    describe "#prep" do
      
      before(:each) do 
        config = {
          "prep" => "clone",
          "field" => "email",
          "targets" => ["Email", "EmailConfirmation"]
        }
        
        @proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:first_name => "Josh", :email => "jfenio@alliancehealth.com"))
        @prepper = Clone.new(config)        
      end

      it "copies the field into multiple targets" do
        # when 
        @prepper.prep(@proxy)
        
        # expect

        @proxy.target["Email"].should == "jfenio@alliancehealth.com"
        @proxy.target["EmailConfirmation"].should == "jfenio@alliancehealth.com"
      end

    end

  end

end
