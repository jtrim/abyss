require 'spec_helper'

describe Abyss do

  before { Abyss.configuration = nil }
  after  { Abyss.configuration = nil }

  describe ".configure" do

    it 'is shorthand for the Abyss Store API' do
      expected_block = Proc.new { }
      fake_config = mock()
      Abyss::Store.stub(:new).and_return(fake_config)
      fake_config.should_receive(:instance_eval).with(&expected_block)

      Abyss.configure &expected_block
    end

  end

  describe '.has?' do

    context "when given a path to an existing configuration" do

      before do
        Abyss.configure do
          three do
            levels do
              deep do
                here "hey!"
              end
            end
          end
        end
      end

      specify { Abyss.has?('three/levels/deep/here').should be_true }

    end

    context "when the config doesn't exist" do

      before do
        Abyss.configure {}
      end

      specify { Abyss.has?('three/levels/deep/here').should be_false }
      specify { Abyss.has?('nope').should be_false }

    end

  end

end
