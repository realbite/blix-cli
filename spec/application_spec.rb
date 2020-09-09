require 'spec_helper'

module Blix::Cli

  describe Application do

    before(:each) do
      Operation.reset!
      @app = Application.new('xxx', :'dry-run'=>true)
    end

    it "should generate an operations list"  do
      expect(Operation.list.length).to eq 0
      Application.new('xxx').setup
      expect(Operation.list.length).to eq  Application::DIR_LIST.length + Application::FILE_LIST.length + 1
      Operation.describe_all
    end

    it "should perform update"  do
      expect(Operation.list.length).to eq 0
      Application.new('.').setup
      expect(Operation.list.length).to eq  Application::DIR_LIST.length + Application::FILE_LIST.length + 1
      Operation.describe_all
    end





  end

end
