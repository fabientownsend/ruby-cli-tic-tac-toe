require 'spec_helper'
require 'board'
require 'cli_interface'

module Lang
  FRENCH = 2
end

RSpec.describe CliInterface do
  let(:input) {StringIO.new("1\n")}
  let(:output) {StringIO.new}
  let(:interface) {CliInterface.new(input, output, "spec/lang/")}

  it "should return a value input" do
    expect(interface.read).to eq("1\n")
  end

  it "should print text from output interface" do
    interface.write("test")

    expect(output.string).to eq("test")
  end

  it "shoudl raise an exception when file doesn't exist" do
    expect {  CliInterface.new(input, output, "random/link") }.to raise_error(NoDefaultLangError)
  end

  it "should display lang based on .yml files in the folder lang" do
    menu = "Select the language\n[ ] - 1 English\n[X] - 2 Francais\n[ ] - 3 Z_last_yml\n"

    checked = 2
    interface.display_lang_menu(checked)

    expect(output.string).to eq(menu)
  end

  it "should return the total of yml file in the folder lang" do
    expect(interface.lang_size_menu).to eq(3)
  end

  it "shoud be english language by default" do
    interface.occupied_position

    expect(output.string).to eq("This position isn't free\n")
  end

  it "shoud display in french when you selected french" do
    expect do
      interface.set_lang(Lang::FRENCH)
      interface.occupied_position
    end.to change { output.string }.to eq("Cette position n'est pas libre\n")
  end

  it "should use the default language when a sentence is missed in the curent file" do
    expect do
      interface.set_lang(Lang::FRENCH)
      interface.must_be_integer
    end.to change { output.string }.to eq("The value must be an integer: ")
  end

  it "should return the next move from the player" do
    expect do
    expect(interface.type_game).to eq("1\n")
    end.to change { output.string }.to eq("Which game do you want?\n")
  end

  it "should displaly blank when the text isn't find in any files" do
    expect do
    expect(interface.first_player_menu)
    end.to change { output.string }.to eq("blank")
  end
end
