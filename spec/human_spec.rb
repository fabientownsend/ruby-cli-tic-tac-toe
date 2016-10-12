require 'spec_helper'
require 'cli_interface'
require 'human'
require 'marks'

RSpec.describe Human do
  it "should give the human number" do
    human = Human.new(Mark::CROSS, set_up_interface("1\n"))

    expect(human.next_move).to eq(1)
  end

  it "should do a second attempt when the first isn't an int" do
    human = Human.new(Mark::CROSS, set_up_interface("asdfhj\n1\n"))

    expect(human.next_move).to eq(1)
  end

  def set_up_interface(input)
    input = StringIO.new(input)
    output = StringIO.new
    CliInterface.new(input, output, "spec/lang/")
  end
end
