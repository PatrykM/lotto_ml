# Class NetworkDumper is responsible for saving and loading networks
class NetworkDumper
  # Default network files directory
  def dir_name
    'network_files/'
  end

  # Return temporary file name
  def file_name
    Pathname("#{dir_name}temporaryfile")
  end

  # Check if temporary file exists
  def file?
    Dir.mkdir(dir_name) unless dir?
    File.exist?(file_name)
  end

  # Check if dir exists
  def dir?
    File.directory?(dir_name)
  end

  # Change file name and return md5 as a new name
  def file_md5
    raise "Temporary file is missing. Can't change a name" unless file?
    md5 = Digest::MD5.file file_name
    File.rename(file_name, "#{dir_name}#{md5.hexdigest}")
    dir_name + md5.hexdigest
  end
end
