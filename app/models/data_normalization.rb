# Normalization class used to normalize input and output data for NN
class DataNormalization
  attr_reader :norm
  # Initialize object with data for normalization
  def initialize(data_set)
    @data_set = data_set
  end

  # Find max value in data set and divide all data by max
  # After normalization all data in data set should be in range 0-1
  def by_maximum
    @data_set.first.is_a?(Hash) ? by_maximum_hash : by_maximum_table
  end

  # Find average value in data set and divide all data by avg
  def by_average
    @data_set.first.is_a?(Hash) ? by_average_hash : by_average_table
  end

  def min_max
    # to implement, possibly very good for nn - check it out
  end

  private

  # Normalize data as table
  def normalize_table
    block = proc { |num| num / @norm }
    if @data_set.first.is_a? Array
      @data_set.map do |row|
        row.collect(&block)
      end
    else
      @data_set.collect(&block)
    end
  end

  # Use maximum to normalize Array @data_set
  def by_maximum_table
    @norm = flatten_data_set.max.to_f
    normalize_table
  end

  # Use average to normalize Array @data_set
  def by_average_table
    @norm = flatten_data_set.reduce(:+) / flatten_data_set.size.to_f
    normalize_table
  end

  # If @data_set is an array of hashes each hash must be the same length
  # Create first hash as long as longest hash with zero values and then merge it
  # with each stage
  def prepare_hash
    first_hash = (0...@data_set.last.length).map { |num| [num, 0] }.to_h
    @data_set.map { |row| first_hash.merge(row) }
  end

  # Normalize data as a hash
  def normalize_hash
    prepare_hash.map do |hash|
      hash.map { |key, value| [key / @norm, value / @norm] }.to_h
    end
  end

  # In LottoGame and MultiGame max is always the same
  # This is only for future games / values
  def by_maximum_hash
    @norm = @data_set.map { |hash| hash.values.max }.max
    normalize_hash
  end

  # Use average to normalize Hash @data_set
  def by_average_hash
    # to implement ...
  end

  def flatten_data_set
    @data_set.flatten
  end
end
