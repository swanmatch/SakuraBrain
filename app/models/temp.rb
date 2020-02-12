class Temp < ActiveRecord::Base
  belongs_to :place

#  def self.calc_min_max
#    all_temps = self.where("DATE_FORMAT(temp_on, '%m') IN ('01', '02', '03', '12')").pluck(:average, :max, :min).flatten
#    MIN = all_temps.minimum(:min)
#    all_temps = all_temps.map{ |temp| temp - MIN }
#    MAX = all_temps.maximum(:max)
#  end
#  calc_min_max
  MIN = self.minimum(:min)
  MAX = self.maximum(:max)

  def self.find_by_place_and_year(place_id, year)
    str_date = Date.parse("#{year-1}-12-01")
    end_date = Date.parse("#{year}-03-31")
    self.where(
      place_id: place_id,
      temp_on: str_date..end_date
    )
  end

  def self.reason(place_id, year)
    self.find_by_place_and_year(place_id, year).limit(120).pluck(:average, :max, :min).flatten.map{ |temp| (temp - MIN) / MAX.to_f }
  end

  def self.average_temp(place_id, date, col_name)
    date = date.strftime("%m/%d") if date.is_a? Date
    raise TypeError unless [:average, :min, :max].include?(col_name.to_sym)
    self.where(place_id: place_id).where("DATE_FORMAT(`temp_on`, '%m/%d') = '#{date}'").average(col_name)
  end

  def self.reason_from_csv(file_name)
    datas =
      CSV.read(file_name, encoding: "Shift_JIS")[5..-1].map do |row|
        [
          (row[1].to_f * 10).to_i,
          (row[2].to_f * 10).to_i,
          (row[3].to_f * 10).to_i
        ]
      end
    datas.flatten.map{ |temp| (temp - MIN) / MAX.to_f }
  end
end
