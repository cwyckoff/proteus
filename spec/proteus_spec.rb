require 'spec_helper'

describe Proteus do

  describe "#process" do

    let(:config) {
      {
        "first_name" => [{"trans" => "map", "target" => "fname"}],
        "last_name" => [{"trans" => "map", "target" => "lname"}],
        "address" => [{"trans" => "map", "target" => "addr"}],
      }
    }
    let(:proteus) { Proteus.new(config) }
    let(:source) { {"first_name" => "Chris", "last_name" => "Wyckoff", "address" => "123 Main St."} }
    
    it "returns a hash" do
      proteus.process(source).should be_a_kind_of(Hash)
    end
    
    it "applies transformations to data" do
      # when
      lead = proteus.process(source)

      # expect
      %w[fname lname addr].each do |key|
        lead.should have_key(key)
      end
    end

    it "applies multiple transformations per field" do
      # given
      transformations = {
        "first_name" => [
                         {"trans" => "lowercase"},
                         {"trans" => "truncate", "limit" => 4},
                         {"trans" => "map", "target" => "fname"}
                        ]
      }
      p = Proteus.new(transformations)
      
      # when
      data = p.process(source)

      # expect
      data["fname"].should == "chri"
    end

    xit "orders fields in the order specified" do
      prepping = {
        "first_name" => [{
                           "prep" => "map",
                           "target" => "fname"
                         }],
        "last_name" => [{
                          "prep" => "map",
                          "target" => "lname"
                        }],
        "address" => [{
                        "prep" => "map",
                        "target" => "addr"
                      }],
        "phone" => [{
                      "prep" => "map",
                      "target" => "phone_num"
                    }],
        "email_address" => [{
                              "prep" => "map",
                              "target" => "email"
                            }],
        "_order" => ["email_address","last_name", "phone", "address", "first_name"]
      }
      field_prepper = Proteus.new(prepping)
      
      # when
      lead = field_prepper.process(@source)
      
      # expect
      lead.to_a.first.should include("email")
      lead.to_a.last.should include("fname")
    end
  end
  
end
