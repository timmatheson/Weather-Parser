require 'rubygems'
require 'rspec'

require File.dirname(__FILE__) + '/../lib/weather.rb'
 
describe "Weather" do
  
  before do
    @max_temp_diff_on_day_10 = File.read(File.dirname(__FILE__) + '/fixtures/max_temp_diff_on_day_10.dat')
    @max_temp_diff_on_day_21 = File.read(File.dirname(__FILE__) + '/fixtures/max_temp_diff_on_day_21.dat')
    @min_temp_diff_on_day_4  = File.read(File.dirname(__FILE__) + '/fixtures/min_temp_diff_on_day_4.dat')
    @min_temp_diff_on_day_30 = File.read(File.dirname(__FILE__) + '/fixtures/min_temp_diff_on_day_30.dat')
  end
  
  context "calculating temprature differences" do
    it "should return the day with the max temprature diff as 10" do
      Weather.new( @max_temp_diff_on_day_10 ).day_of_max_temp_diff.should == 10
    end
    
    it "should return the day with the max temprature diff as 21" do
      Weather.new( @max_temp_diff_on_day_21 ).day_of_max_temp_diff.should == 21
    end
    
    it "should return the day with the max temprature diff as 4" do
      Weather.new( @min_temp_diff_on_day_4 ).day_of_min_temp_diff.should == 4
    end
    
    it "should return the day with the max temprature diff as 30" do
      Weather.new( @min_temp_diff_on_day_30 ).day_of_min_temp_diff.should == 30
    end
  end
end