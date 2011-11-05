require 'spec_helper'
require 'mini_transformer'
require 'mini_transformer/cli'

describe "CLI" do
  it "should check for a version" do
    mini_transform :version, :exitstatus => true
    @exitstatus.should eq(0)
    out.should == "Mini Transform version 0.0.1"
  end

  it "should be able to check version with -v" do
    mini_transform "-v"
    out.should == "Mini Transform version 0.0.1"
  end
  
  it "should be able to check version with --version" do
    mini_transform "--version"
    out.should == "Mini Transform version 0.0.1"
  end
end

describe "MiniTransformer::CLI" do
  
  before(:all) do
    @cli = MiniTransformer::CLI.new
  end
  
  it "should check version" do
    @cli.version.should == "Mini Transform version 0.0.1"
  end

  
end