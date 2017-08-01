class Temp < ActiveRecord::Base
  belongs_to :place

#  def self.calc_min_max
#    all_temps = self.where("DATE_FORMAT(temp_on, '%m') IN ('01', '02', '03', '04', '05')").pluck(:average, :max, :min).flatten
    MIN = self.minimum(:min)
#    all_temps = all_temps.map{ |temp| temp - MIN }
    MAX = self.maximum(:max)
#  end
#  calc_min_max

  def self.find_by_place_and_year(place_id, year)
    str_date = Date.parse("#{year}-01-01")
    end_date = Date.parse("#{year}-05-31")
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
end
