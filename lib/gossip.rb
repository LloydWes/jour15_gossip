require 'bundler'
Bundler.require
require 'csv'

class Gossip
  attr_accessor :author, :content
  def initialize(author, content)
    @author = author
    @content = content
    # puts "Makin gossip with #{@author} and #{@content}"
  end

  def self.all
    gossips_array = Array.new
    path = File.expand_path('../db/gossip.csv', __dir__)
    CSV.foreach(path) do |row|
      gossips_array << Gossip.new(row.first, row.last)
    end
    return gossips_array
  end

  def self.find(index_arg)
    path = File.expand_path('../db/gossip.csv', __dir__)
    # csv_file = CSV.new(path)
    n = 0
    CSV.foreach(path) do |row|
      puts "Checking #{n} with #{index_arg} for #{row} #{row.class}"
      if n == index_arg.to_i
        return Gossip.new(row.first, row.last)
      end 
      n += 1
    end
    # csv_file.each_with_index do |row, current_index|
    #   print "\n\nChecking for index #{current_index} #{row} to match #{index_arg}\n"
    #   if current_index == index_arg
    #     return Gossip.new(row.first, row.last)
    #   end
    #   print "Not returned \n\n"
    # end
  end

  def save
    # puts "Saving"
    path = File.expand_path('../db/gossip.csv', __dir__)
    CSV.open(path, "a") do |csv|
      csv << [@author, @content]
    end
    # file = File.open(path, 'a')
    # file.write("#{@author.strip},#{@content.strip}\n")
    # file.close
  end
  def self.delete_gossip(gossip_to_delete)
    path = File.expand_path('../db/gossip.csv', __dir__)
    path2 = File.expand_path('../db/gossip2.csv', __dir__)
    # file = File.open(path, "a+")
    # file.each

    File.open(path2, 'w') do |out_file|
      File.foreach(path).with_index do |line,line_number|
        out_file.puts line if line_number != gossip_to_delete  # <== line numbers start at 0
      end
    end
    path = path.gsub(" " , "\ ")
    path2 = path2.gsub(" " , "\ ")
    `mv #{path2} #{path}`
  end
end

# Gossip.new("lloyd"," holala").save
# CSV.foreach("path/to/file.csv") do |row|