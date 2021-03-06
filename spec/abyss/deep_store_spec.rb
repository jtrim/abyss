require 'spec_helper'

module Abyss

  describe ".configure" do

    before { Abyss.configuration = nil }

    it 'is shorthand for the Abyss Config API' do
      expected_block = Proc.new { }
      fake_config = mock()
      Store.stub(:new).and_return(fake_config)
      fake_config.should_receive(:instance_eval).with(&expected_block)

      Abyss.configure &expected_block
    end

  end

  describe DeepStore do

    context "when dealing directly with an instance of DeepStore" do

      subject { DeepStore.new("some_name") }

      describe "#initialize" do

        its(:configurations) { should == ActiveSupport::OrderedHash.new }
        its(:name)           { should == "some_name" }

        context "when not specifying a name in the constructor" do
          subject { DeepStore.new }
          its(:name) { should be_nil }
        end

      end

      describe "#get" do

        it "returns what is stored in its #configurations" do
          subject.configurations = { :thing => 'foo' }
          subject.get(:thing).should == 'foo'
        end

      end

      describe "#assign" do

        it 'raises an error about subclassing' do
          expect {
            subject.some_nonexistent_method "foo"
          }.to raise_error /must override #assign in a base class/i
        end

      end

      describe "#method_missing behavior" do

        context "when given a block" do

          let(:config_mock) { mock }
          let(:empty_proc)  { proc {} }

          before do
            # force evaluation since we stub :new
            subject
          end

          it "creates a new named configuration group" do
            subject.some_undefined_method &empty_proc
            subject.some_undefined_method.should be_instance_of subject.class
          end

          it "evaluates the block against a new configuration instance" do
            DeepStore.stub(:new).and_return(config_mock)
            config_mock.should_receive(:instance_eval).with &empty_proc
            subject.some_undefined_method &empty_proc
          end

          context "with arguments" do

            it "initializes a new configuration instance with the passed args" do
              DeepStore.should_receive(:new).with(:some_undefined_method, "foo")
              subject.some_undefined_method "foo", &empty_proc
            end

          end

        end

        context "with no arguments and no block" do

          it "returns a configuration stored by the method name" do
            subject.should_receive(:get).with(:some_undefined_method)
            subject.some_undefined_method
          end

        end

        context "with an argument" do

          it "calls #assign on itself, passing the method name and args list" do
            subject.should_receive(:assign).with(:some_undefined_method, ['foo'])
            subject.some_undefined_method 'foo'
          end

        end

      end

    end

  end

end
