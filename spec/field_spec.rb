require 'spec_helper'

module Protean
  describe Field do

    describe "#transform" do

      let(:source) { {"first_name" => "Chris", "last_name" => "Wyckoff"} } 
      let(:field) { Field.new(["first_name", [{"trans" => "uppercase"}]]) }
      
      it "returns a hash" do
        field.transform(source).should == {"first_name" => "CHRIS"}
      end

      it "modifies source hash based on specified transformations" do
        field.transform(source).should be_an_instance_of(Hash)
      end

      it "applies multiple transformations" do
        # given
        field = Field.new(["first_name", [{"trans" => "lowercase"}, {"trans" => "truncate", "limit" => 4}, {"trans" => "map", "target" => "fname"}]])

        # when
        data = field.transform(source)

        # expect
        data["fname"].should == "chri"
      end

      it "applies multiple transformations regardless of when the key transformation occurs" do
        # given
        field = Field.new(["first_name", [{"trans" => "lowercase"}, {"trans" => "map", "target" => "fname"}, {"trans" => "truncate", "limit" => 4}]])

        # when
        data = field.transform(source)

        # expect
        data["fname"].should == "chri"
      end
      
      context "sub, or child transformations exist" do

        it "processes them before parent transformation" do
          # given
          transformations = [
                             {"trans" => "concatenate", "separator" => ", ", "format" => "last_name, first_name"},
                             {"sub_trans" => {"first_name" => [{"trans" => "uppercase"}], "last_name" => [{"trans" => "truncate", "limit" => "2"}]}}
                            ]
          field = Field.new(["full_name", transformations])

          # when
          result = field.transform(source)

          # expect
          result["full_name"].should == "Wy, CHRIS"
        end

      end
      
      context "source hash is modified" do

        it "raises a ProteusImmutableSourceError error" do
          # given
          source.freeze
          field = Field.new(["first_name", [{"trans" => "rogue"}]])
          
          # expect
          lambda { field.transform(source) }.should raise_error(Protean::ImmutableSourceError)
        end

      end
    end
  end
end
