require 'bundler'
Bundler.require
require 'csv'

class Comment
  attr_accessor :author, :content, :gossip_number
  @@path = File.expand_path('../db/comments.csv', __dir__)
  def initialize(gossip_number, author, content)
    @author = author
    @content = content
    @gossip_number = gossip_number
  end

  def self.all
    comments_array = Array.new
    CSV.foreach(@@path) do |row|
      comments_array << Comment.new(row.first, row[1], row.last)
    end
    return comments_array
  end

  def self.get_by_id(id)
    comments_array = Array.new
    CSV.foreach(@@path) do |row|
      if row.first == id
        comments_array << Comment.new(row.first, row[1], row.last)
      end
    end
    return comments_array
  end

  def save
    @author.gsub(/[<>\n\r\/]/, "").strip!
    @content.gsub(/[<>\n\r\/]/, "").strip!
    CSV.open(@@path, "a+") do |csv|
      csv << [@gossip_number,@author,@content]
    end
  end

end