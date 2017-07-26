json.extract! temp, :id, :place_id, :temp_on, :average, :max, :min, :created_at, :updated_at
json.url temp_url(temp, format: :json)
