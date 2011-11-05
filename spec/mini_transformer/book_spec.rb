require 'spec_helper'
require 'mini_transformer'
require 'mini_transformer/book'

describe "Book" do

  context "Given a new Book" do
    it "should respond to all Book attributes" do
      @book = MiniTransformer::Book.new
      expect { @book.title }.to_not raise_error
      @book.respond_to?(:title).should be_true
      @book.respond_to?(:id).should be_true
      @book.respond_to?(:uid).should be_true
      @book.respond_to?(:introduction).should be_true
      @book.respond_to?(:key_list).should be_true
      @book.respond_to?(:type).should be_true

      @book.respond_to?(:adfadfasfasdff).should be_false
    end
  end
end