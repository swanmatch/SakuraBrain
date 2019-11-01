# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'net/http'
require 'uri'
require 'csv'

# Places
puts "start insert to place datas!"
Place.connection.execute("TRUNCATE TABLE places;")
places = CSV.read('./db/datas/place.csv')
places.each do |p|
  place =
    Place.new(
      name: p[0],
        cd: p[1],
    )
  place.save!
end

# mankai kaika
puts "start insert to open_on and full_on datas!"
Sakura.connection.execute("TRUNCATE TABLE sakuras;")
mankai = CSV.read('./db/datas/mankai.csv', headers: true)
kaika_table  = CSV.read('./db/datas/kaika.csv', headers: true)
kaika = {}
# kaika convert hash table
kaika_table.each_with_index do |k_row|
  kaika[k_row[0]] = {}
  k_row.each_with_index do |k_cell, i|
    if 0 < i
      kaika[k_row[0]][k_cell[0].to_i] = k_cell[1]
    end
  end
end
# insert laerning data
mankai.each do |mankai_row|
  place = Place.where(name: mankai_row[0]).first
  if place
    mankai_row.each_with_index do |mankai_hash, i|
      mankai_cell = mankai_hash[1]
      year = mankai.headers[i].to_i
      kaika_cell = kaika[mankai_row[0]][year]
      if 0 < i && mankai_cell != '-' && kaika_cell != '-'
        Sakura.new(
          place: place,
          year: year,
          full_on: Date.parse("#{year}/#{mankai_cell}").yday,
          open_on: Date.parse("#{year}/#{kaika[mankai_row[0]][year]}").yday
        ).save!
      end
    end
  end
end

puts "start download to temperature datas!"
SESSION_ID = 'sov27o8aecot691auvba7g2d55'
# get files
Sakura.includes(:place).references(:place).all.each do |sakura|
  place_cd = sakura.place.try :cd
  year = sakura.year
  file = "./db/datas/temp/#{place_cd}_#{year}.csv"
  if place_cd && !(File.exist? file)
#    `curl http://www.data.jma.go.jp/gmd/risk/obsdl/show/table -d 'stationNumList=["#{place_cd}"]&aggrgPeriod=1&elementNumList=[["201",""],["202",""],["203",""]]&interAnnualFlag=1&ymdList=["#{year}","#{year}","1","6","1","1"]&optionNumList=[]&downloadFlag=true&rmkFlag=0&disconnectFlag=0&youbiFlag=0&fukenFlag=0&kijiFlag=0&huukouFlag=0&csvFlag=1&jikantaiFlag=0&jikantaiList=[]&ymdLiteral=1&PHPSESSID=#{SESSION_ID}' -XPOST -o ./db/datas/temp/#{place_cd}_#{year}.csv`

    uri = URI.parse("http://www.data.jma.go.jp/gmd/risk/obsdl/show/table")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      "stationNumList" => "[\"#{place_cd}\"]",
      "aggrgPeriod" => "1",
      "elementNumList" => "[[\"201\",\"\"],[\"202\",\"\"],[\"203\",\"\"]]",
      "interAnnualFlag" => "1",
      "ymdList" => "[\"#{year-1}\",\"#{year}\",\"12\",\"3\",\"1\",\"31\"]",
      "optionNumList" => "[]",
      "downloadFlag" => "true",
      "rmkFlag" => "0",
      "disconnectFlag" => "0",
      "youbiFlag" => "0",
      "fukenFlag" => "0",
      "kijiFlag" => "0",
      "huukouFlag" => "0",
      "csvFlag" => "1",
      "jikantaiFlag" => "0",
      "jikantaiList" => "[]",
      "ymdLiteral" => "1",
      "PHPSESSID" => "#{SESSION_ID}",
    )

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    puts response.code if response.code != '200'
    File.open(file, "wb") do |f|
      f.puts response.body
    end

    sleep 1

    nil
  else
    puts sakura.attributes
  end
end

puts "start insert to temperature datas!"

Temp.connection.execute("TRUNCATE TABLE temps;")
Dir.glob('./db/datas/temp/*.csv').each do |file_name|
  cd, year = File.basename(file_name).split("_")
  place_id = Place.where(cd: cd).first.try(:id)
  rows = CSV.read(file_name, encoding: "Shift_JIS")[5..-1]
  sqls = []
  rows.each do |row|
    if row.map(&:present?).all?
      unless Temp.exists?(place_id: place_id,temp_on: Date.parse(row[0]))
        now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        sqls << "(#{place_id}, '#{Date.parse(row[0])}', #{(row[1].to_f * 10).to_i}, #{(row[2].to_f * 10).to_i}, #{(row[3].to_f * 10).to_i}, '#{now}', '#{now}')"
      end
    end
  end
#        Temp.new(
#          place_id: place_id,
#          temp_on: Date.parse(row[0]),
#          average: row[1].to_f * 10,
#          min: row[2].to_f * 10,
#          max: row[3].to_f * 10,
#        ).save!
  ActiveRecord::Base.connection.execute( <<EOB )
INSERT INTO temps
  (place_id, temp_on, average, max, min, created_at, updated_at)
VALUES
  #{sqls.join(",\n  ")};
EOB
end

