require 'bundler'
Bundler.require
require 'csv'

class Gossip
  attr_reader :author, :content, :path

  @@path = File.expand_path('../db/gossip.csv', __dir__)
  def initialize(author, content)
    @author = author
    @content = content
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
    success = csv_chil.SetCell(index_arg.to_i, 0, new_author.gsub(/[<>\n\r]/, ""))
    success = csv_chil.SetCell(index_arg.to_i, 1, new_content.gsub(/[<>\n\r]/, ""))

    success = csv_chil.SaveFile(@@path)
    if success
      return "La modification du gossip a réussi"
    else
      return "Oups on dirait qu'il y a eu un problème pendant le modification du gossip #{csv_chil.lastErrorText()} ça peut aider"
    end
  end

  def self.find(index_arg)
    n = 0
    CSV.foreach(@@path) do |row|
      puts "Checking #{n} with #{index_arg} for #{row} #{row.class}"
      puts row
      if n == index_arg.to_i
        return Gossip.new(row.first, row.last)
      end 
      n += 1
    end
  end

  def save
    @author.gsub(/[<>\n\r]/, "").strip!
    @content.gsub(/[<>\n\r]/, "").strip!
    CSV.open(@@path, "a+") do |csv|
      csv << [@author,@content]
    end
  end
end