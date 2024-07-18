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
  attr_accessor :cards, :storage
  def initialize
    @cards = []
    @storage = []
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
  attr_accessor :name, :have, :front_card
  def initialize(name)
    @name = name
    @have = []
    @front_card = []
  end

  def push_card
    @front_card = @have.shift
  end

  def maximum(*players)
    @players.each do |player|
      @storage << player.front_card.num
    end
    puts @storage
  end
end
# player1 = Player.new("田中")
# player2 = Player.new("佐藤")
# puts player1.name
# deck.distribute(player1,player2)
# puts player1.have.size


class Game
  #プレイヤーを定義
  #デッキの準備
  def initialize(*player_names)
    @players = player_names.map{ |name| Player.new(name) }
    @deck = Deck.new
  end

  def compare_cards
    #出したカードの出力
    @players.each do |player|
      player.push_card
      puts "#{player.name}のカードは#{player.front_card.full_name}です。"
    end
  end

  #ゲームスタート
  def start
    puts "戦争を開始します。"
    @deck.distribute(*@players)
    puts "カードが配られました。"
    puts "戦争！"

    compare_cards
    #if @players.map{ |player| player }
    #勝敗の決定
    highest_value = @players.max_by{ |player| player.front_card.value }
    highest_players = @players.select{ |player| player.front_card.value == highest_value.front_card.value }
      if highest_players.size == 1
        puts "#{highest_value.name}が勝ちました。"
        #相手と自分のfront_cardとデッキストレイジを手元に置く
        #相手の手元にあったカードの枚数と相手がデッキストレイジに送った枚数を出力する
      else
        #@players.map { |player| @deck.storage << player.front_card }
        それぞれの手元に置く
        メソッドを切り出して繰り返す
      end
      #@players.each do |player|
      # highest_value.have << player.front_card
      # highest_value.have << @deck.storage if @deck.storage.any?
    end
  end
end

game = Game.new("プレイヤー１", "プレイヤー２")
game.start
