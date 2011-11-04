require 'spec_helper'
require 'mini_transformer'
require 'nokogiri'

describe MiniTransformer do
  FIXTURES_DIR = File.join(File.dirname(__FILE__), "fixtures")
  describe "Version" do
    it "should have a version" do
      MiniTransformer::VERSION.should_not be_nil
    end
  end

end
