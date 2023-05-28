require 'pry'
require_relative 'song'

class Artist
  attr_accessor :name
  attr_reader :songs

  @@artists = []

  def initialize
    @@artists << self
    @songs = []
  end

  def self.find_by_name(name)
    @@artists.detect{|a| a.name == name}
  end

  def self.all
    @@artists
  end

  def self.reset_all
    self.all.clear
  end

  def self.count
    self.all.count
  end

  def add_song(song)
    @songs << song
    song.artist = self
  end

  def add_songs(songs)
    songs.each { |song| add_song(song) }
  end

  def to_param
    name.downcase.gsub(' ', '-')
  end
end

# output
song1 = Song.new
song1.name = "Song 1"

song2 = Song.new
song2.name = "Song 2"

artist = Artist.new
artist.name = "Artist"

artist.add_song(song1)
artist.add_song(song2)

puts "Total songs: #{Song.count}"         # Output: Total songs: 2
puts "Total artists: #{Artist.count}"     # Output: Total artists: 1

found_song = Song.find_by_name("Song 2")
puts "Found song: #{found_song.name}"     # Output: Found song: Song 2

found_artist = Artist.find_by_name("Artist")
puts "Found artist: #{found_artist.name}" # Output: Found artist: Artist

puts "Artist songs: #{found_artist.songs.map(&:name)}" # Output: Artist songs: [Song 1, Song 2]

