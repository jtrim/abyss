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

      subject { DeepStore.new }

      describe "#initialize" do

        it 'sets its #configurations to an empty OrderedHash' do
          subject.configurations.should == ActiveSupport::OrderedHash.new
        end

      end

      describe "#get" do

        it "returns what is stored in its #configurations" do
          subject.configurations = { thing: 'foo' }
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

        context "when given a block and no args" do

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

        describe "invalid scenarios" do

          context "with an argument and a block" do

            it "raises an InvalidArguemnt error" do
              expect {
                subject.some_undefined_method("foo") {}
              }.to raise_error ArgumentError, /can't supply both a method argument and a block/i
            end

          end

        end

      end

    end

  end

end
