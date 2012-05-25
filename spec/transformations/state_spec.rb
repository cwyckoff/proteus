require 'spec_helper'

module Preppers

  describe State do

    describe "#prep" do

      before(:each) do
        @config = {
          "field" => "state",
          "prep" => "state"
        }
        @proxy = FieldsProxy.new(HashWithIndifferentAccess.new(
                                                               :first_name => "Chris",
                                                               :last_name => "Wyckoff",
                                                               :postal_code => '66208-1234',
                                                               :state => 'KS',
                                                               :address => "123 Main St."
                                                               )
                                 )
        @prepper = State.new(@config)
      end
      
      it "maps the state abbreviation to a full name" do
        # when
        @prepper.prep(@proxy)

        # expect
        @proxy.target.should == {"state" => 'Kansas'}
      end

      it "returns the original value if it can't map it" do
        # given
        proxy = FieldsProxy.new(HashWithIndifferentAccess.new({:first_name => "Chris", :last_name => "Wycoff", :state => "KK"}))

        # when
        @prepper.prep(proxy)

        # expect
        proxy.target.should == {"state" => "KK"}
      end
    end

  end

end
