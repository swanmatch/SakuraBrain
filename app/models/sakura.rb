class Sakura < ActiveRecord::Base
  belongs_to :place

#  MIN = self.minimum(:full_on)
#  MAX = self.maximum(:full_on)
#  DIFF = MAX - MIN
  # output laern_datas
  # Example
  #   inputs_set, ouputs_sets = Sakura.laern_datas
  def self.laern_datas
    reasons = []
    results = []
    self.all.each do |sakura|
      reason = Temp.reason(sakura.place_id, sakura.year)
#      if reason.count == 120 * 3
      reasons << reason
      results << sakura.from_new_years_day
#      end
    end
    [reasons, results]
  end

  def self.new_from_results(result_sets, year = Date.today.year)
    min = Sakura.minimum(:full_on)
    max = Sakura.maximum(:full_on)
    diff = max - min
    new_years_day = Date.parse("#{year-1}-12-01") + Sakura.minimum(:full_on)
    result_sets.map do |f|
      new_years_day + (f * diff).to_i.days
    end
  end

#  def from_new_years_day(cols = [:open_on, :full_on])
  def from_new_years_day(cols = [:full_on])
    min = Sakura.minimum(:full_on)
    max = Sakura.maximum(:full_on)
    diff = max - min
    cols.map do |col|
      (self.try(col) - min).to_i / diff.to_f
    end
  end

end
