require 'rubygems'
require 'nokogiri'
require 'fastercsv'

class Weather
  def initialize( string )
    @doc = Nokogiri::HTML( string )
  end
  
  def data
    return @data if @data
    
    lines  = @doc.xpath("//pre").inner_html.to_s.each_line.to_a[3..-1]
    header = lines.shift.split
    lines.map! do |line| 
      line.split.map(&:to_i)
    end
    
    @data = ( [header] | lines).reject{ |a| a if a.empty? }
    
    return @data
  end
  
  def day_of_max_temp_diff    
    @day_of_max_temp_diff ||= calculate_diff( :max )
  end
  
  def day_of_min_temp_diff
    @day_of_min_temp_diff ||= calculate_diff( :min )
  end
  
  private
  
  def calculate_diff( method )    
    rows = data[1..-2]
    diffs = rows.map do |row|
      (row[1].to_i - row[2].to_i).abs
    end
    
    rows[diffs.index(diffs.send(method))][0]
  end
end