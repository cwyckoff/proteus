require 'spec_helper'

describe Proteus do

  describe "#process" do

    let(:fields) {
      {
        "first_name" => [{"trans" => "map", "target" => "fname"}],
        "last_name" => [{"trans" => "map", "target" => "lname"}],
        "address" => [{"trans" => "map", "target" => "addr"}],
      }
    }
    let(:proteus) { Proteus.new(fields) }
    let(:source) { {"first_name" => "Chris", "last_name" => "Wyckoff", "address" => "123 Main St."} }

    it "returns a hash" do
      proteus.process(source).should be_a_kind_of(Hash)
    end

    it "freezes the source" do
      # given
      fields = {"first_name" => [{"trans" => "rogue"}]}

      # expect
      lambda { Proteus.new(fields).process({:first_name => "Chris"}) }.should raise_error(Protean::ImmutableSourceError)
    end

    it "applies transformations to data" do
      # when
      lead = proteus.process(source)

      # expect
      %w[fname lname addr].each do |key|
        lead.should have_key(key)
      end
    end

    it "handles remove transformations correctly" do
      # given
      source = {"address" => "6650 Malachite Way", "address2" => ""}
      fields = {"address" => [{"trans" => "map", "target" => "add"}], "address2" => [{"trans" => "remove", "conditional" => "blank?"}]}
      p = Proteus.new(fields)

      # when
      data = p.process(source)

      # expect
      data.should == {"add" => "6650 Malachite Way"}
    end
  end

  describe ".order" do

    let(:source) { {"first_name" => "Chris", "last_name" => "Wyckoff", "address" => "9 Exchange Place", "phone" => "801-555-1234", "email_address" => "cwyckoff@test.com"} }
    let(:fields) { {
        "first_name" => [{"trans" => "map", "target" => "fname"}],
        "last_name" => [{"trans" => "map", "target" => "lname"}],
        "address" => [{"trans" => "map", "target" => "addr"}],
        "phone" => [{"trans" => "map", "target" => "phone_num"}],
        "email_address" => [{"trans" => "map", "target" => "email"}]
      } }
    
    it "sorts fields in the order specified" do
      order = ["email","lname", "phone_num", "addr", "fname"]
      p = Proteus.new(fields)

      # when
      lead = p.process(source)
      ordered_lead = Proteus.order(lead, order)

      # expect
      ordered_lead.keys.should == ["email","lname", "phone_num", "addr", "fname"]
    end

    it "sorts fields last if not specified" do
      order = ["email","lname","addr", "fname"]
      p = Proteus.new(fields)

      # when
      lead = p.process(source)
      ordered_lead = Proteus.order(lead, order)

      # expect
      ordered_lead.keys.should == ["email","lname", "addr","fname","phone_num"]
    end
  end

end
