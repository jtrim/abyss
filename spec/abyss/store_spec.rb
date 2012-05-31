require 'spec_helper'

module Abyss

  describe Store do

    subject { Store.new }

    it "is a subclass of DeepStore" do
      subject.should be_a DeepStore
    end

    describe "#assign" do

      it "assigns the method name to the first passed value in #configurations" do
        subject.assign("thing", ["foo"])
        subject.configurations["thing"].should == "foo"
      end

    end

  end

end
