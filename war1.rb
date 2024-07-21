class Card
  attr_accessor :num, :mark
  def initialize(num, mark)
    @num = num
    @mark = mark
  end

  def full_name
    "#{mark}の#{num}"
  end

  def number
    "#{num}"
  end

  def value
    case num
    when "J" then 11
    when "Q" then 12
    when "K" then 13
    when "A" then 14
    else num.to_i
    end
  end
end

# card = Card.new("2", "ハート")
# puts card.full_name

class Deck
  attr_accessor :cards
  def initialize
    @cards = []
    numbers = (2..10).to_a + ["A", "J", "Q", "K"]
    marks = ["ハート", "スペード", "ダイヤ", "クローバー"]
    marks.each do |mark|
      numbers.each do |num|
        @cards << Card.new(num, mark)
      end
    end
    @cards.shuffle!
  end

  def distribute(*players)
    while @cards.any?
      players.each do |player|
        player.have << @cards.shift if @cards.any?
      end
    end
  end
end

# deck = Deck.new
# puts deck.cards.size

class Player
  attr_accessor :name, :have, :front_card, :storage
  def initialize(name)
    @name = name
    @have = []
    @front_card = []
    @storage = []
  end

  def push_card
    @front_card.unshift(@have.shift)
  end
end


class Game
  #プレイヤーを定義
  #デッキの準備
  def initialize(*player_names)
    @players = player_names.map{ |name| Player.new(name) }
    @deck = Deck.new
  end

  def compare_cards
    puts "戦争！"
    #出したカードの出力
    @players.each do |player|
      player.push_card
      puts "#{player.name}のカードは#{player.front_card.first.full_name}です。"
    end
  end
  #勝敗決定後のカードの受け渡し枚数
  def deliver_count
    @players.first.front_card.length * (@players.length - 1)
  end

  def replenishment
    @players.each do |player|
      if player.have.empty? && player.storage.any?
        player.storage.shuffle!
        player.have.concat(player.storage)
        player.storage.clear
      end
    end
  end
  def liquidation
    @players.each do |player|
      player.have.concat(player.storage)
      player.storage.clear
    end
  end

  def end_game
    @players.any? { |player| player.have.empty? }
  end

  def war_result
    #勝敗の決定
    highest_value = @players.max_by{ |player| player.front_card.first.value }
    highest_players = @players.select{ |player| player.front_card.first.value == highest_value.front_card.first.value }
    if highest_players.size == 1

      puts "#{highest_value.name}が勝ちました。#{highest_value.name}はカードを#{deliver_count}枚もらいました。"
      #勝ったプレイヤーのstorageに入れる
      highest_value.storage.concat(@players.flat_map { |player| player.front_card })
      @players.map { |player| player.front_card.clear }

    else
      puts "引き分けです。"
    end
  end

  def ranking
    @players = @players.sort_by { |player| -(player.have.length) }
    @players.each_with_index do |player, index|
      print "#{player.name}が#{index + 1}位です。"
    end
  end

  def final_result
    liquidation
    @players.map do |player|
      puts "#{player.name}の手札がなくなりました。" if player.have.empty?
    end
    @players.map do |player|
      print "#{player.name}の手札の枚数は#{player.have.length}枚です。"
    end
    puts"\n"
    ranking
    puts"\n"
    puts "戦争を終了します。"
  end

  #ゲームスタート
  def start
    @deck.distribute(*@players)
    until end_game do
      compare_cards
      war_result
      replenishment

    end
    final_result
  end
end

puts "戦争を開始します。"
puts "カードが配られました。"
game = Game.new("プレイヤー１", "プレイヤー２", "プレイヤー３")
game.start
#誰かの手札がなくなったらゲーム終了し、順位を表示するようにしましょう。この時点での手札の枚数が多い順に1位、2位を出力する
