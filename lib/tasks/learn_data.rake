# coding: utf-8

MODEL = [120*3, 1]
FILE = './weights/file.yml'


namespace :learn_data do
  desc "学習データの作成"
  task :make, [:max_traning_count, :learning_rate] => :environment do |task, args|
    max_traning_count = args.max_traning_count.to_i
    max_traning_count = 100 if max_traning_count == 0
    learning_rate = args.learning_rate.to_f
    learning_rate = 0.4 if learning_rate == 0.0
    training_input_set, training_supervisor_set = Sakura.laern_datas

    # ネットワーク作成
    a_network = RubyBrain::Network.new(MODEL)
    a_network.learning_rate = learning_rate
    a_network.init_network
    # 学習開始
    puts "#{Time.now}: 学習開始"
    a_network.learn(training_input_set, training_supervisor_set, max_traning_count, 0.03)
    a_network.dump_weights_to_yaml(FILE)
    puts "#{Time.now}: 学習終了"
  end

  desc "作成した重みで試験"
  task :test, [:test_num] => :environment do |task, args|
    test_num = args.test_num.to_i
    test_num = 100 if test_num == 0
    a_network = RubyBrain::Network.new MODEL
    a_network.init_network
    a_network.load_weights_from_yaml_file(FILE)
#    a_network.load_weights_from_yaml_file('./weights/best_weights_.yml')
#    open_correct  = 0
    full_correct  = 0
#    open_diff_all = 0
    full_diff_all = 0
    Sakura.all.sample(test_num).each do |sakura|
      reason = Temp.reason(sakura.place_id, sakura.year)
      mid_results = a_network.get_forward_outputs reason
      results = Sakura.new_from_results mid_results, sakura.year
#      open_diff = (results[0] - sakura.open_on).to_i
#      full_diff = (results[1] - sakura.full_on).to_i
      full_diff = results[0].yday - sakura.full_on
#      puts "#{sakura.year}年 #{sakura.place.try(:name).to_s.ljust(4, '　')}開花日-正解:#{sakura.open_on.strftime("%m/%d")} 予測:#{results[0].strftime("%m/%d")}  満開日-正解:#{sakura.full_on.strftime("%m/%d")} 予測:#{results[1].strftime("%m/%d")}"
      puts "#{sakura.year}年 #{sakura.place.try(:name).to_s.ljust(4, '　')}  満開日-正解:#{(Date.parse("2017/01/01") + sakura.full_on.days).strftime("%m/%d")} 予測:#{results[0].strftime("%m/%d")}"
#      open_correct += 1 if open_diff == 0
      full_correct += 1 if full_diff == 0
#      open_diff_all += open_diff.abs
      full_diff_all += full_diff.abs
    end
    puts <<EOB

*************************************
満開正解数　： #{full_correct}/#{test_num}
満開平均誤差： #{full_diff_all / test_num.to_f}日
*************************************
EOB
  end

  desc "最適な学習率を探す"
  task search: :environment do
    nums = [100, 500, 1000, 2000, 3000]
    lates = [0.01, 0.025, 0.05, 0.1, 0.2, 0.4]
    training_input_set, training_supervisor_set = Sakura.laern_datas
    results = []
    test_num = 1000

    nums.each do |max_traning_count|
      lates.each do |learning_rate|
        # 学習
        a_network = RubyBrain::Network.new(MODEL)
        a_network.learning_rate = learning_rate
        a_network.init_network
        a_network.learn(training_input_set, training_supervisor_set, max_traning_count, 0.001)

        # テスト
        full_diff_all = 0
        Sakura.all.sample(test_num).each do |sakura|
          reason = Temp.reason(sakura.place_id, sakura.year)
          mid_results = a_network.get_forward_outputs reason
          results = Sakura.new_from_results mid_results, sakura.year
          full_diff = results[0].yday - sakura.full_on
          full_diff_all += full_diff.abs
        end
        result = {diff: full_diff_all/test_num.to_f, max_traning_count: max_traning_count, learning_rate: learning_rate}
        puts result
        results << result
      end
    end
    results.sort_by!{|a| a[:diff]}
    puts ""
    puts results
  end


end
