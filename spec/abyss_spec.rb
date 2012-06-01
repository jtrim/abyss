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

  describe 'access and validation mechanisms' do

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

    describe '.has?' do

      it 'returns true when the value exists' do
        Abyss.has?('three/levels/deep/here').should be_true
      end

      context "when the config doesn't exist" do

        before do
          Abyss.configuration = nil
          Abyss.configure {}
        end

        specify { Abyss.has?('three/levels/deep/here').should be_false }
        specify { Abyss.has?('nope').should be_false }

      end

    end

    describe '.get' do

      it 'returns the value when it exists' do
        Abyss.get('three/levels/deep/here').should == 'hey!'
      end

      it "returns nil if it doesn't" do
        Abyss.get('nope').should be_false
        Abyss.get('no/can/do').should be_false
      end

    end

    describe '.get!' do

      it 'returns the value when it exists' do
        Abyss.get('three/levels/deep/here').should == 'hey!'
      end

      it "raises an error when it doesn't" do
        expect { Abyss.get!('nope').should be_false }.to raise_error Abyss::Errors::NotFound, /'nope' not found/
        expect { Abyss.get!('no/can/do').should be_false }.to raise_error Abyss::Errors::NotFound, /'no\/can\/do' not found/
      end

    end

  end

end
