# encoding: utf-8

#require "debug"

# frozen_string_literal: true
# 2~Aまでの優劣を定義？カードを4枚ずつ用意する
# プレイヤーは2人
# カードをシャッフルして均等に配る
# 戦争！の文字を出力する
# プレイヤー各々の先頭のカードを出力
# 出したカードの高い方のプレイヤーが場に出たカードをもらえる
# カードが被った場合は場にプールしておいて、次の勝負を始める勝ち負けが決まればプールしてあるものを含めてもらえる
# 勝った方の名前を出力して終了


class User
  attr_accessor :user_name, :users_card
  def initialize(user_name, users_card)
    @user_name = user_name
    @users_card = users_card
  end
end

class Card
  NUMBERS = { "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9, "10" => 10, "J" => 11, "Q" => 12, "K" => 13, "A" => 14 }
  MARKS = ["ハート" ,"ダイヤ", "スペード", "クラブ" ]
  attr_accessor :num, :mark
  def initialize(num, mark)
    @num = num
    @mark = mark
  end

  def self.full_cards
    cards = MARKS.flat_map do |mark|
      NUMBERS.keys.map{ |num| Card.new(num, mark)}
    end
  end

  def card_strong
    NUMBERS[value]
  end
end

class Deck
  attr_accessor :cards
  def initialize
    @cards = Card.full_cards
  end
end

class Game
  def initialize(user1, user2)
    @user1 = User.new(user1, have1)




end
puts deck
puts "戦争を開始します。"

puts "カードが配られました。"
puts "戦争！"

puts "#{user.name}は#{push_card}です。"
puts "#{user.name}は#{push_card}です。"

puts "#{result}です。"

puts "戦争を終了します。"
