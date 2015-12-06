# encoding: utf-8
#
# $ rake postcode:update のように使う。
# Linux 環境 で動かす場合は unzip, iconv が必須です。
#
# 読み仮名データの促音・拗音を小書きで表記するもの(zip形式)
# http://www.post.japanpost.jp/zipcode/dl/kogaki-zip.html
# http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip

require 'open-uri'

namespace :postcode do

  POSTCODE_URI = 'http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip'
  POSTCODE_CSV = "#{Rails.root}/tmp/KEN_ALL.CSV"

  desc "郵便番号データを取得し、 postcodes モデルに反映させる"
  task :update => :environment do
    %w(download conv_utf8 set).each do |task|
      Rake::Task["postcode:#{task}"].invoke
    end
  end


  desc "郵便局の郵便番号データを取得して展開する"
  task :download => :environment do
    file = "#{Rails.root}/tmp/#{File.basename(POSTCODE_URI)}"

    # 現在 tmp 以下にある不要なファイルを削除
    system("rm #{file} #{POSTCODE_CSV}")

    # ファイルを取得して保存
    open(file, 'wb') do |output|
      open(POSTCODE_URI) do |data|
        output.write(data.read)
      end
    end
    puts "downloaded."

    # csv ファイルに展開する
    system("unzip #{file} -d#{Rails.root}/tmp/")
    puts "unzipped."
  end

  desc "郵便局の郵便番号データを SHIFT_JIS -> UTF-8 に変換する"
  task :conv_utf8 => :environment do
    system("iconv -f SHIFT_JIS -t UTF8 #{POSTCODE_CSV} > #{POSTCODE_CSV}.utf8")
    puts "converted."
  end

  desc "郵便番号データを postcode モデルに反映させる"
  task :set => :environment do
    ActiveRecord::Base.transaction do
      Postcode.connection.truncate(:postcodes)
      Postcode.connection.execute <<-EOF
        LOAD DATA INFILE '#{POSTCODE_CSV}.utf8'
        INTO TABLE postcodes
        FIELDS TERMINATED BY ','
        ENCLOSED BY '"'
        LINES TERMINATED BY '\r\n'
        (@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15)
        SET postcode = @3, prefecture = @7, city = @8, address = @9;
      EOF
    end
    puts "inserted."
  end

end
