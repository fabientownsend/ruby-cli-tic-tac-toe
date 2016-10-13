[![Build Status](https://travis-ci.org/fabientownsend/tic-tac-toe.svg?branch=master)](https://travis-ci.org/fabientownsend/tic-tac-toe)
[![Coverage Status](https://coveralls.io/repos/github/fabientownsend/tic-tac-toe/badge.svg?branch=master)](https://coveralls.io/github/fabientownsend/tic-tac-toe?branch=master)
#Unbeatable Tic-Tac-Toe with Ruby
![tictactoe](https://lh3.googleusercontent.com/-a9v5dd-AVfc/VqzalVGTb6I/AAAAAAAAF5A/rIYiW0SVVfU/w1406-h794-no/tictactoe.png)

## Install the project
```bash
$ git clone https://github.com/fabientownsend/tic-tac-toe
$ cd tic-tac-toe
$ gem install bundle
$ bundle install --binstubs
```
## Run the game
1. Language menu let you choose the language of the game.
2. Type of game menu, it let you want to play.
3. First player menu, it let you choose who should start.
4. The game started, you can set your a mark between 0 and 8

**Example**
```bash
$ bundle exec ruby ./bin/tic_tac_toe
$ 2 #select english language
$ 2 #select Human vs. Computer type game
$ 1 #let the player one start
$ 4 #put the mark on the position 4
```

## Run the tests
**Run all tests**
```bash
$ bundle exec rspec
```

**Run class tests**
```bash
$ bundle exec rspec spec/class_name.rb
```

**Run methot test**
```bash
$ bundle exec rspec spec/class_name.rb:12
```
note that 12 is the line of the test

## How to add a new language
You only need to add a new *my_new_language.yml* file into lang folder with its traduction.
The name of the language in the menu is based on the filename.

Language available:
- German
- English
- French
