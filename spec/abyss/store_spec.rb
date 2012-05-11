require 'spec_helper'

module Abyss

  describe ".configure" do

    before { Abyss.configuration = nil }

    it 'is shorthand for the Abyss Store API' do
      expected_block = Proc.new { }
      fake_config = mock()
      Store.stub(:new).and_return(fake_config)
      fake_config.should_receive(:instance_eval).with(&expected_block)

      Abyss.configure &expected_block
    end

  end

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
