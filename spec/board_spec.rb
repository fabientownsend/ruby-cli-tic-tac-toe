require 'spec_helper'
require 'board_helper'
require 'board'
require 'marks'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:board_helper) { BoardHelper.new(board) }

  it "is a free spot when the spot isn't used" do
    position = 0
    board_helper.string_to_board("   ,   ,   ")
    expect(board.free_positions.include?(position)).to be true
  end

  it "isn't a free position when the spot is used" do
    position = 0
    board_helper.string_to_board("X  ,   ,   ")

    expect(board.free_positions.include?(position)).to be false
  end

  it "is a win with the first column" do
    board_helper.string_to_board("XO ,XO ,X  ")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "is a win with the second column" do
    board_helper.string_to_board(" XO, XO, X ")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "is a win with the third column" do
    board_helper.string_to_board(" OX, OX,  X")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "is a win with the first line" do
    board_helper.string_to_board("XXX, OO,   ")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "is a win with the second line" do
    board_helper.string_to_board("   ,XXX,OO ")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "is a win with the third line" do
    board_helper.string_to_board("   ,O  ,XXX")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "is a win with the forward diagonal" do
    board_helper.string_to_board("XO ,OX ,  X")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "is a win with the backward diagonal" do
    board_helper.string_to_board(" OX,OX ,X  ")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "shoud be a tie" do
    board_helper.string_to_board("XOX,XOX,OXO")

    expect(board.tie?).to be true
  end

  it "shoud not be a tie when it's a win" do
    board_helper.string_to_board("XXX,XXX,XXX")

    expect(board.tie?).to be false
  end

  it "create a board 3x3" do
    board = Board.new(3)
    board_helper = BoardHelper.new(board)
    expect(board_helper.board_to_string).to eq("   ,   ,   ")
  end

  it "create a board 4x4" do
    board = Board.new(4)
    board_helper = BoardHelper.new(board)
    expect(board_helper.board_to_string).to eq("    ,    ,    ,    ")
  end
end
