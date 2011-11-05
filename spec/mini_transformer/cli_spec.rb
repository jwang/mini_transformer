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
  it "should run a minitransformer with input.json input.xml" do
    @cli.transform("#{FIXTURES_DIR}/input.json", "#{FIXTURES_DIR}/input.xml")
  end
  it "should raise an error if the either the input.json or input.xml cannot be found" do
    expect { @cli.transform("input.json", "input.xml") }.to raise_error(RuntimeError, "File Not Found.")
  end
  
  
  it "should be able to export out to json if format=json is given" do
    @cli.transform("#{FIXTURES_DIR}/input.json", "#{FIXTURES_DIR}/input.xml", "ouput.json", "json")
  end
  
end