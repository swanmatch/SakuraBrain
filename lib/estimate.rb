module Estimate
  MODEL = [150*3, 1]
  FILE = './weights/file.yml'

  def self.read(file_path)
    CSV.read(file_path, encoding: "Shift_JIS")[5..-1].map do |temps|
      [temps[1], temps[3], temps[5] ].map do |temp|
        ((temp.to_f * 10).to_i - Temp::MIN) / Temp::MAX.to_f
      end
    end.flatten[0..(150*3)]
  end

  def self.run(file_path)
    a_network = RubyBrain::Network.new MODEL
    a_network.init_network
    a_network.load_weights_from_yaml_file(FILE)

    mid_results = a_network.get_forward_outputs self.read(file_path)
    results = Sakura.new_from_results mid_results, Date.today.year
    puts results[0]
  end
end
