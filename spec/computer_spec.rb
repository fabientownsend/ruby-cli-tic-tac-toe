require 'spec_helper'
require 'board_helper'
require 'board'
require 'computer'
require 'marks'

RSpec.describe Computer do
  let (:input) { StringIO.new("1\n") }
  let (:output) { StringIO.new }
  let (:board) { Board.new }
  let (:board_helper) { BoardHelper.new(board) }

  it "Computer block its opponent in a row" do
    board_helper.string_to_board("OOX,XXO,   ")

    computer = Computer.new(Mark::ROUND, board)

    board.set_mark(computer.mark, computer.next_move)
    expect(board_helper.board_to_string).to eq("OOX,XXO,O  ")
  end

  it "Computer block its opponent in a diagonal" do
    board_helper.string_to_board("XO ,  O,  X")

    computer = Computer.new(Mark::ROUND, board)

    board.set_mark(computer.mark, computer.next_move)
    expect(board_helper.board_to_string).to eq("XO , OO,  X")
  end

  it "Computer block its opponent in a column" do
    board_helper.string_to_board("XO ,X O,   ")

    computer = Computer.new(Mark::ROUND, board)

    board.set_mark(computer.mark, computer.next_move)
    expect(board_helper.board_to_string).to eq("XO ,X O,O  ")
  end

  it "Computer move to win in a row" do
    board_helper.string_to_board("XXO,OO ,   ")

    computer = Computer.new(Mark::ROUND, board)

    board.set_mark(computer.mark, computer.next_move)
    expect(board_helper.board_to_string).to eq("XXO,OOO,   ")
  end

  it "Computer move to win in a row" do
    board_helper.string_to_board("XXO, XO,   ")

    computer = Computer.new(Mark::ROUND, board)

    board.set_mark(computer.mark, computer.next_move)
    expect(board_helper.board_to_string).to eq("XXO, XO,  O")
  end

  it "Computer move to win in a diagonal" do
    board_helper.string_to_board("XXO, OX,   ")

    computer = Computer.new(Mark::ROUND, board)

    board.set_mark(computer.mark, computer.next_move)
    expect(board_helper.board_to_string).to eq("XXO, OX,O  ")
  end
end
