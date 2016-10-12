require 'spec_helper'
require 'cli_interface'
require 'game_play'

RSpec.describe GamePlay do
  let(:output) { StringIO.new }

  it "should finish the game displaying a tie" do
    type_game = "1\n"
    first_player = "1\n"
    moves = "0\n1\n2\n4\n3\n6\n5\n8\n7\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("It's a tie!\n")
  end

  it "type game Human vs. Computer when user use default value by typing enter" do
    type_game = "\n"
    first_player = "1\n"
    game_play = create_game_play("#{type_game}#{first_player}")

    game_play.game_selection
    game_play.select_first_player
    expect(game_play.current_player).to be_a(Computer)
  end

  it "should be a computer as first player" do
    type_game = "2\n"
    first_player = "1\n"
    game_play = create_game_play("#{type_game}#{first_player}")

    game_play.game_selection
    game_play.select_first_player
    expect(game_play.current_player).to be_a(Computer)
  end

  it "should finish the game with X as a winner" do
    type_game = "1\n"
    first_player = "1\n"
    moves = "0\n1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: X")
  end

  it "should finish the game with O as a winner" do
    type_game = "1\n"
    first_player = "2\n"
    moves = "0\n1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: O")
  end

  it "should be win by the player two with the second move already played" do
    type_game = "1\n"
    first_player = "2\n"
    moves_part_one = "0\n"
    already_played = "0\n"
    moves_part_two = "1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves_part_one}#{already_played}#{moves_part_two}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: O")
  end

  it "should be win by the player two with the second move too hight" do
    type_game = "1\n"
    first_player = "2\n"
    moves_part_one = "0\n"
    too_hight = "100\n"
    moves_part_two = "1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves_part_one}#{too_hight}#{moves_part_two}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: O")
  end


  it "should be win by the player two (round) with the second move too low" do
    type_game = "1\n"
    first_player = "2\n"
    moves_part_one = "0\n"
    too_low = "-100\n"
    moves_part_two = "1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves_part_one}#{too_low}#{moves_part_two}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: O")
  end

  it "should be win by the player two (round) with the second move invalid" do
    type_game = "1\n"
    first_player = "2\n"
    moves_part_one = "0\n"
    invalid_move = "fdhasjfjd\n"
    moves_part_two = "1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves_part_one}#{invalid_move}#{moves_part_two}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: O")
  end

  it "should be a tie when computer vs computer" do
    type_game = "3\n"
    first_player = "1\n"
    game_play = create_game_play("#{type_game}#{first_player}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("It's a tie!\n")
  end

  it "should display the next menu in another language" do
    lang = "2\n"
    type_game = "3\n"
    game_play = create_game_play("#{lang}#{type_game}")

    expect do
      game_play.language
      game_play.game_selection
    end.to change { output.string }.to include("Ordinateur vs. Ordinateur")
  end

  it "shoudl ask a second time when value is too hight with menus" do
    lang = "100\n2\n"
    type_game = "3\n"
    game_play = create_game_play("#{lang}#{type_game}")

    expect do
      game_play.language
      game_play.game_selection
    end.to change { output.string }.to include("Ordinateur vs. Ordinateur")
  end

  it "shoudl ask a second time when value is too low with menus" do
    lang = "-100\n2\n"
    type_game = "3\n"
    game_play = create_game_play("#{lang}#{type_game}")

    expect do
      game_play.language
      game_play.game_selection
    end.to change { output.string }.to include("Ordinateur vs. Ordinateur")
  end

  it "shoudl ask a second time when value is too low with menus" do
    menu_board_size = "2\n"
    lang = "asdfdsafhjkl\n2\n"
    type_game = "3\n"
    game_play = create_game_play("#{menu_board_size}#{lang}#{type_game}")

    expect do
      game_play.board_size
      game_play.language
      game_play.game_selection
    end.to change { output.string }.to include("Ordinateur vs. Ordinateur")
  end

  def create_game_play(input)
    input = StringIO.new(input)
    interface = CliInterface.new(input, output, "spec/lang/")
    return GamePlay.new(interface)
  end
end
