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
        player.have << @cards.shift
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
        player.have << player.storage.shuffle!
      end
    end
  end

  def end_game
    @players.each do |player|
      if player.have.empty? && player.storage.empty?
        puts "#{player.name}の手札がなくなりました。"
        final_result
      end
    end
  end
  def war_result
    #勝敗の決定
    highest_value = @players.max_by{ |player| player.front_card.first.value }
    highest_players = @players.select{ |player| player.front_card.first.value == highest_value.front_card.first.value }
    if highest_players.size == 1

      puts "#{highest_value.name}が勝ちました。#{highest_value.name}はカードを#{deliver_count}枚もらいました。"

      #勝ったプレイヤーのstorageに入れる
      highest_value.storage << @players.map { |player| player.front_card }
    else
      puts "引き分けです。"
      if @players.map { |player| player.front_card }
        replenishment
        end_game
        compare_cards
        war_result
      end
    end
  end
  def final_result
    puts "戦争を終了します。"
  end

  #ゲームスタート
  def start
    @deck.distribute(*@players)
    loop do
      puts "戦争を開始します。"
      puts "カードが配られました。"
      replenishment
      end_game
      compare_cards
      war_result
    end
  end
end

game = Game.new("プレイヤー１", "プレイヤー２","プレイヤー３")
game.start
#誰かの手札がなくなったらゲーム終了し、順位を表示するようにしましょう。この時点での手札の枚数が多い順に1位、2位を出力する
