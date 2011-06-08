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
    return @day_of_max_temp_diff if @day_of_max_temp_diff

    rows = data[1..-2]
    diffs = rows.map do |row|
      (row[1].to_i - row[2].to_i).abs
    end
    
    @day_of_max_temp_diff = rows[diffs.index(diffs.max)][0]
    
    @day_of_max_temp_diff
  end
end