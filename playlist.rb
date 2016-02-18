class Song
  attr_reader :name, :artist, :duration
  FILE_TYPES = ["mp3", "wav", "aac"]

  def initialize(name, artist, duration)
    @name = name
    @artist = artist
    @duration = duration
  end

  def play
    puts "Playing '#{name}' by #{artist} (#{duration} mins)..."
  end

   def tagline
    "#{@name} - #{artist}"
  end

  def filename
    @name.gsub(" ", "-").downcase + "-" + @artist.gsub(" ", "-").downcase
  end

  def each_filename
    FILE_TYPES.each { |f| yield filename + "." + f }
  end
end

song1 = Song.new("Wicked Game", "Chris Isaak", 4.47)
song2 = Song.new("Gimme Shelter", "Rolling Stones", 4.31)
song3 = Song.new("The Thrill is Gone", "B.B. King", 5.24)
song4 = Song.new("Baby Did A Bad Bad Thing", "Chris Isaak", 2.56)
song5 = Song.new("Blue Hotel", "Chris Isaak", 3.12)
song6 = Song.new("Shelter From the Storm", "Bob Dylan", 5.01)

class Playlist
  include Enumerable
  
  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    @songs << song
  end

  def each
    @songs.each { |song| yield song }   
  end

  def play_songs
  each { |song| song.play } 
  end

  def each_tagline
    @songs.each { |song| yield "#{song.name} - #{song.artist}" }
  end

  def each_by_artist(artist)
    select { |song| song.artist == artist }.each { |song| yield song }
  end
end

playlist = Playlist.new("Classic")
playlist.add_song(song1)
playlist.add_song(song2)
playlist.add_song(song3)
playlist.add_song(song4)
playlist.add_song(song5)
playlist.add_song(song6)

playlist.each { |song| song.play }

playlist.play_songs

shelter_songs = playlist.select { |song| song.name =~ /Shelter/ }
p shelter_songs

non_shelter_songs = playlist.reject { |song| song.name =~ /Shelter/}
p non_shelter_songs

p playlist.any? { |song| song.artist == "Chris Isaak"  }
p playlist.detect { |song| song.artist =="Chris Isaak" }

song_labels = playlist.map { |song| "#{song.name} - #{song.artist}" }
p song_labels

total_duration = playlist.reduce(0) { |sum, song| sum + song.duration }
p total_duration

playlist.each_tagline { |tagline| puts tagline }

song1.each_filename { |filename| puts filename }
puts song1.filename

playlist.each_by_artist("Rolling Stones") { |song| song.play }

playlist.each_by_artist("B.B. King") { |song| song.play }

playlist.each_by_artist("Chris Isaak") { |song| song.play }

playlist.reverse_each { |s| s.play}