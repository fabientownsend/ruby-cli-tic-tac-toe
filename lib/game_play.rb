require 'players_factory'
require 'board'
require 'game'

module GameType
  HUMAN_VS_HUMAN = 1
  HUMAN_VS_COMPUTER = 2
  COMPUTER_VS_COMPUTER = 3
end

class GamePlay
  attr_reader :current_player

  def initialize(ui)
    @board = Board.new
    @ui = ui
    @VALUE_MIN = 1
    @game = nil
  end

  def board_size
    default_size = 1

    @ui.display_board_menu(default_size)
    menu_size = @ui.board_size_menu
    selection = get_user_value(@VALUE_MIN, menu_size, default_size)

    selection += 2

    @board = Board.new(selection)
  end

  def language
    default_lang = 2

    @ui.display_lang_menu(default_lang)
    menu_size = @ui.lang_size_menu
    selection = get_user_value(@VALUE_MIN, menu_size, default_lang)

    @ui.set_lang(selection)
  end

  def game_selection
    default_game = 2

    @ui.display_type_game_menu(default_game)
    menu_size = @ui.type_game_size_menu
    selection = get_user_value(@VALUE_MIN, menu_size, default_game)

    create_players_for_game(selection)
  end

  def select_first_player
    default_first_player = 1

    @ui.first_player_menu(default_first_player)
    selection = get_user_value(@VALUE_MIN, @players.size, default_first_player)

    set_next_player(selection)
  end

  def play
    until @game.over?
      display_board
      play_move
    end

    display_board
    display_result
  end

  private

  attr_reader :board
  attr_reader :ui

  def get_user_value(min, max, default = 1)
    value = @ui.get_value

    if value == "\n"
      return default
    elsif !is_integer(value)
      @ui.must_be_integer
      value = get_user_value(min, max)
    elsif !Integer(value).between?(min, max)
      @ui.should_be_between(min, max)
      value = get_user_value(min, max)
    end

    Integer(value)
  end

  def is_integer(value)
    begin
      Integer(value)
    rescue
      return false
    end
  end

  def set_next_player(selection)
    if selection == 1
      @game = Game.new(@board, @players[0], @players[1])
    else
      @players.reverse!
      @game = Game.new(@board, @players[0], @players[1])
    end
  end

  def create_players_for_game(type_selected)
    players_factory = PlayersFactory.new(ui, board)

    if type_selected == GameType::HUMAN_VS_HUMAN
      @players = players_factory.create_human_vs_human
    elsif type_selected == GameType::HUMAN_VS_COMPUTER
      @players = players_factory.create_human_vs_computer
    elsif type_selected == GameType::COMPUTER_VS_COMPUTER
      @players = players_factory.create_computer_vs_computer
    end
  end

  def display_result
    if (@game.over? && @game.winner.empty?)
      ui.tie
    else
      ui.winner(@game.winner)
    end
  end

  def display_board
    @ui.display_board(board.board)
  end

  def play_move
    ui.display_next_player(@game.current_player.mark)
    @game.play
  end
end
