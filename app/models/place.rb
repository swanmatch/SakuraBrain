class Place < ActiveRecord::Base
  has_many :temps
  has_many :sakuras
end
