#!/usr/bin/env ruby
require './lib/google'
class Main
  def initialize
    offset = 0
    limit = 11
    @index = 1
    formulate_input
    google = Google.new
    input = @name
    while (input != "" && input != "q") do 
      @books = google.get_books_by_name(@name,offset)
      input = "" if display_books.nil?
      STDOUT.puts "\nEnter Y to get more books and press enter to quit"
      input = STDIN.gets.chomp
      offset += limit
    end
  end

private
  def display_books
    STDOUT.puts "Showing books for '#{@name}':"
    return if @books.nil?
    @books.each do |book|

      next if book['volumeInfo'].nil?
      title = book['volumeInfo']['title'] if book['volumeInfo']['title']
      authors = book['volumeInfo']['authors'] || nil
      STDOUT.puts "#{@index}: #{title} #{authors ? 'by ' + authors.join(',') : ''}"
      @index += 1
    end
  end
  def formulate_input
    if ARGV.length === 1
      @name = ARGV.first
    elsif ARGV.length === 0
      STDOUT.puts "[Input] Enter a book name: "
      @name = gets.chomp
      if @name === ""
        STDERR.puts "No book name entered!"
        STDERR.puts "Usage: \nbookshelf [bookname]"
        exit
      end
    else
      STDOUT.puts "[!] Take it easy, only one argument is needed :)"
      @name = ARGV.first
    end
  end
end

Main.new