require 'marks'

class Board
  attr_reader :board
  attr_reader :POSITION_MIN
  attr_reader :POSITION_MAX

  def initialize(board_size = 3)
    @board = create_board(board_size)
    @POSITION_MIN = 0
    @POSITION_MAX = board.size ** 2
  end

  def set_mark(mark, position)
    board[get_row(position)][get_column(position)] = mark
  end

  def remove_mark(position, value)
    board[get_row(position)][get_column(position)] = value
  end

  def win?(mark)
    win_with_columns?(mark) || win_with_rows?(mark) || win_with_diagonal?(mark)
  end

  def tie?
    @board.flatten.none? { |mark| mark.is_a?(Integer) } && !win?(Mark::CROSS) && !win?(Mark::ROUND)
  end

  def free_positions
    flat_board = board.flatten
    flat_board.each_index.select { |index| empty?(flat_board[index]) }
  end

  private

  def empty?(spot)
    spot != Mark::ROUND && spot != Mark::CROSS
  end

  def create_board(board_size)
    id = 0

    new_board = Array.new
    board_size.times do
      new_row = Array.new
      board_size.times do
        new_row.push(id)
        id += 1
      end
      new_board.push(new_row)
    end
    new_board
  end

  def get_column(position)
    position % board.size
  end

  def get_row(position)
    position / board.size
  end

  def win_with_columns?(mark)
    board.transpose.any? { |column| same_symbol?(column, mark) }
  end

  def win_with_rows?(mark)
    board.any? { |row| same_symbol?(row, mark) }
  end

  def same_symbol?(rows, mark)
    rows.all? { |row| row == mark }
  end

  def win_with_diagonal?(mark)
    check_forward_diagonal?(mark) || check_backward_diagonal?(mark)
  end

  def check_forward_diagonal?(mark)
    board.size.times.all? { |index| board[index][index] == mark }
  end

  def check_backward_diagonal?(mark)
    board.size.times.all? { |index| board[index][backward_index(index)] == mark }
  end

  def backward_index(index)
    board.size - index - 1
  end
end
