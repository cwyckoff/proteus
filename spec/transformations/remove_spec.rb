require 'spec_helper'

module Preppers

  describe Remove do
    
    describe "#prep" do
      before(:each) do
        @config  = {
          "prep" => "remove",
          "if" => "blank?",
          "field" => "last_name"
        }

        @source = HashWithIndifferentAccess.new(:first_name => "Josh", :last_name => "", :email => "jfenio@alliancehealth.com")
        @proxy = FieldsProxy.new(@source)
        @prepper = Remove.new(@config)
      end
      
      it "removes the field if it fulfills the 'if' conditional" do
        # when 
        @prepper.prep(@proxy)
        
        # expect
        @proxy.target.should_not have_key('last_name')
      end

      it "doesn't remove the field if it doesn't fulfill the 'if' conditional" do
        # when
        proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:first_name => "Josh", :last_name => "Fenio", :email => "jfenio@alliancehealth.com"))
        @prepper.prep(proxy)
        
        # expect
        proxy.target.should have_key('last_name')
      end

      it "removes all subsequent preppers if it fulfills the 'if' conditional" do
        # given
        prepping = {
          "last_name" => [{
                            "prep" => "remove",
                            "if" => "blank?",
                            "field" => "last_name"
                          },
                          {
                            "prep" => "map",
                            "target" => "lname"
                          }]
        }
        
        field_prepper = FieldPrepper.new(prepping)
        
        # when 
        lead = field_prepper.process(@source)

        # expect
        lead.should_not have_key("lname")
      end
      
      it "removes multiple fields if the keys array has been provided" do
        # given
        prepping = {
          "last_name" => [{
                            "prep" => "remove",
                            "keys" => ["email", "first_name"]
                          }]
        }
        
        field_prepper = FieldPrepper.new(prepping)

        # when
        lead = field_prepper.process(@source)
        
        # expect
        lead.should_not have_key("email")
        lead.should_not have_key("first_name")
      end

    end

  end

end
