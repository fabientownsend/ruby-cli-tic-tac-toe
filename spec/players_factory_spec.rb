require 'spec_helper'
require 'players_factory'
require 'marks'

RSpec.describe PlayersFactory do
  let(:players_factory) { PlayersFactory.new(nil, nil) }

  it "should return two human players" do
    human_players = players_factory.create_human_vs_human

    human_players.each { |player| expect(player).to be_a(Human) }
  end

  it "should create two human with different mark" do
    human_players = players_factory.create_human_vs_human

    expect(human_players[0].mark).to eq(Mark::CROSS)
    expect(human_players[1].mark).to eq(Mark::ROUND)
  end

  it "should return two computer players with different mark" do
    computer_players = players_factory.create_computer_vs_computer

    computer_players.each { |player| expect(player).to be_a(Computer) }
  end

  it "should create two computer with different mark" do
    computer_players = players_factory.create_computer_vs_computer

    expect(computer_players[0].mark).to eq(Mark::CROSS)
    expect(computer_players[1].mark).to eq(Mark::ROUND)
  end

  it "should return one human and one computer players with different mark" do
    players = players_factory.create_human_vs_computer

    expect(players[0]).to be_a(Human)
    expect(players[1]).to be_a(Computer)
  end
end
