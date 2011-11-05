require 'spec_helper'
require 'mini_transformer'
require 'mini_transformer/key_list'

describe "KeyList" do
  context "Given a new KeyList" do
    it "should respond to all KeyList attributes" do
      @key_list = MiniTransformer::KeyList.new
      expect { @key_list.name }.to_not raise_error
      @key_list.respond_to?(:name).should be_true
      @key_list.respond_to?(:key_label).should be_true
      @key_list.respond_to?(:description_label).should be_true
      @key_list.respond_to?(:entries).should be_true
    end
  end
end