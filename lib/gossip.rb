require 'bundler'
Bundler.require
require 'csv'

class Gossip
  attr_accessor :author, :content, :path

  @@path = File.expand_path('../db/gossip.csv', __dir__)
  def initialize(author, content)
    @author = author
    @content = content
    # puts "Makin gossip with #{@author} and #{@content}"
  end

  def self.all
    gossips_array = Array.new
    CSV.foreach(@@path) do |row|
      gossips_array << Gossip.new(row.first, row.last)
    end
    return gossips_array
  end

  def self.update(index_arg, new_author, new_content)
    csv_chil = Chilkat::CkCsv.new()
    success = csv_chil.LoadFile(@@path)
    success = csv_chil.SetCell(index_arg.to_i, 0, new_author.gsub(/[<>]/, ""))
    success = csv_chil.SetCell(index_arg.to_i, 1, new_content.gsub(/[<>]/, ""))

    success = csv_chil.SaveFile(@@path)
    if success
      return "La modification du gossip a réussi"
    else
      return "Oups on dirait qu'il y a eu un problème pendant le modification du gossip #{csv_chil.lastErrorText()} ça peut aider"
    end
  end

  def self.find(index_arg)
    # path = File.expand_path('../db/gossip.csv', __dir__)
    # csv_file = CSV.new(path)
    n = 0
    CSV.foreach(@@path) do |row|
      puts "Checking #{n} with #{index_arg} for #{row} #{row.class}"
      puts row
      if n == index_arg.to_i
        return Gossip.new(row.first, row.last)
      end 
      n += 1
    end
    #Méthode plus propre à comprendre (marche pas encore)
    # csv_file.each_with_index do |row, current_index|
    #   print "\n\nChecking for index #{current_index} #{row} to match #{index_arg}\n"
    #   if current_index == index_arg
    #     return Gossip.new(row.first, row.last)
    #   end
    #   print "Not returned \n\n"
    # end
  end

  def save
    @author.gsub!(/[<>]/, "")
    @content.gsub!(/[<>]/, "")
    CSV.open(@@path, "a") do |csv|
      csv << [@author, @content]
    end
  end
  def self.delete_gossip(gossip_to_delete)
    path = @@path
    path2 = @@path

    File.open(path2, 'w') do |out_file|
      File.foreach(path).with_index do |line,line_number|
        out_file.puts line if line_number != gossip_to_delete
      end
    end
    path = path.gsub(" " , "\ ")
    path2 = path2.gsub(" " , "\ ")
    `mv #{path2} #{path}`
  end
end

# Gossip.new("lloyd"," holala").save
# CSV.foreach("path/to/file.csv") do |row|
