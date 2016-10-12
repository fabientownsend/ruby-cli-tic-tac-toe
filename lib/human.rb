require 'player'

class Human < Player
  attr_reader :ui

  def initialize(mark, ui)
    super(mark)
    @ui = ui
  end

  def next_move
    ui.get_int
  end
end
