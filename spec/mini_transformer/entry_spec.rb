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
    
    it "should convert to JSON" do
      @entry = MiniTransformer::Entry.new
      @entry.key_name = "-"
      @entry.description = "A setting that applies to only part of the selection"
      json = @entry.to_json
      expect { JSON.parse json }.to_not raise_error(JSON::JSONError)
    end
    
  end
end