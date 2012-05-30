require 'spec_helper'

def transformations_with_children
  [
   {"trans" => "concatenate", "separator" => ", ", "format" => "last_name, first_name"},
   {"sub_trans" => {"first_name" => [{"trans" => "uppercase"}], "last_name" => [{"trans" => "truncate", "limit" => "2"}]}}
  ]
end

def childless_transformations
  [{"trans"=>"uppercase"}]
end


module Protean
  module Transformations

    describe Collection do

      let(:collection) { Collection.new(["first_name", childless_transformations]) }

      describe "#<<" do

        it "appends parameter to Collection transformations" do
          # expect
          collection.transformations.size.should == 1

          # when
          collection << childless_transformations

          # expect
          collection.transformations.size.should == 2
        end

      end
      
      describe "#each" do

        it "yields a Transformation object" do
          # expect
          collection.transformations.should_not be_empty

          # when
          transformations = collection.map { |t| t }
          
          # expect
          transformations.first.should be_an_instance_of(Uppercase)
        end

      end

      describe "#children" do

        context "no children exist" do

          it "returns an empty array" do
            collection.children.should == []
          end
          
        end

        context "children exist" do

          it "returns a hash of transformation hashes" do
            # given
            collection = Collection.new(["full_name", transformations_with_children])

            # expect
            collection.children.should == transformations_with_children.last["sub_trans"]
          end
          
        end

      end

      describe "#have_children?" do

        context "children exist" do

          it "returns true" do
            # given
            collection = Collection.new(["full_name", transformations_with_children])

            # expect
            collection.has_children?.should be_true
          end
          
        end
        
        context "children do not exist" do

          it "returns false" do
            # given
            collection = Collection.new(["full_name", childless_transformations])

            # expect
            collection.has_children?.should be_false
          end
          
        end
      end
    end
  end
end
