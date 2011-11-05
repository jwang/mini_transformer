require 'spec_helper'
require 'mini_transformer'
require 'mini_transformer/entry'

describe "Entry" do

  context "Given a new Entry" do
    it "should respond to all Entry attributes" do
      @entry = MiniTransformer::Entry.new
      expect { @entry.key_name }.to_not raise_error
      @entry.respond_to?(:key_name).should be_true
      @entry.respond_to?(:description).should be_true
    end
  end
end