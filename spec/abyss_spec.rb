
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

end

