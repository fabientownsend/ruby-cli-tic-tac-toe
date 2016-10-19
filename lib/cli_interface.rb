require 'yaml'

class CliInterface
  attr_accessor :input
  attr_accessor :output

  def initialize(input, output, source)
    @input = input
    @output = output
    @source = source
    @FILE_EXTENTION = ".yml"

    begin
      @default_file = YAML::load(File.open("#{source}english.yml"))
    rescue
      raise NoDefaultLangError
    end

    @text_file = @default_file
  end

  def set_lang(input)
    file = Dir.glob("#{@source}*#{@FILE_EXTENTION}").sort[input - 1].to_s
    @text_file = YAML::load(File.open(file))
  end

  def display_type_game_menu(default_checked_type = 1)
    display_menu(from_file('menu_game_types'), default_checked_type)
  end

  def type_game_size_menu
    from_file('menu_game_types').lines.size - 1
  end

  def display_lang_menu(default_checked_lang = 1)
    display_menu(menu_lang, default_checked_lang)
  end

  def lang_size_menu
    menu_lang.lines.size - 1
  end

  def first_player_menu(default_checked_first_player = 1)
    display_menu(from_file('menu_first_player'), default_checked_first_player)
  end

  def display_board(board)
    board.each_with_index do |line, index|
      display_line(line)
      if index != last_line(board)
        display_interline(line)
      end
    end
  end

  def display_next_player(mark)
    write("#{mark} #{from_file('next_move')}\n")
  end

  def type_game
    write("#{from_file('which_game')}\n")
    read
  end

  def occupied_position
    write("#{from_file('not_free')}\n")
  end

  def winner(mark)
    write("#{from_file('winner')}: #{mark}!\n")
  end

  def tie
    write("#{from_file('tie')}\n")
  end

  def must_be_integer
    write("#{from_file('integer')}: ")
  end

  def should_be_between(min, max)
      write("#{from_file('between')} #{min} #{from_file('and')} #{max}\n")
  end

  def read
    input.gets
  end

  def write(text)
    output.print(text)
  end

  def get_int
    begin
      selection = Integer(read)
    rescue
      must_be_integer
      selection = get_int
    end

    selection
  end

  def get_value
    read
  end

  def display_board_menu(default_size = 1)
    display_menu(from_file('board_size'), default_size)
  end

  def board_size_menu
    from_file('board_size').lines.size - 1
  end

  private

  attr_reader :text_file

  def last_line(board)
    board.size - 1
  end

  def display_menu(menu, checked_menu)
    menu.each_line.with_index do |line, index|
      if index == 0
        write(line)
      elsif index == checked_menu
        write("[X] - #{index} " + line)
      else
        write("[ ] - #{index} " + line)
      end
    end
  end

  def from_file(text)
    result = text_file[text]

    if result == nil
      result = @default_file[text]
      if result == nil
        result = "blank"
      end
    end

    result
  end

  def display_line(row)
    content = " "

    row.each_with_index do |mark, index|
      if end_of_row?(index, row)
        write("#{mark}".center(width_margin(row), content)  + "\n")
      else
        write("#{mark}".center(width_margin(row), content)  + "|")
      end
    end
  end

  def end_of_row?(index, row)
    index == row.size - 1
  end

  def display_interline(row)
    write( "-" * board_width(row) + "\n")
  end

  def board_width(row)
    row.size + width_margin(row) * row.size - 1
  end

  def width_margin(row)
      (row.size ** 2).to_s.size + 2
  end

  def menu_lang
    menu_lang = "#{from_file('menu_lang')}\n"
    languages = ""

    Dir.entries(@source).each do |language|
      if language.end_with?("#{@FILE_EXTENTION}")
        languages  << format_language_name(language)
      end
    end

    menu_lang << languages.lines.sort.join
  end

  def format_language_name(language)
    "#{language.chomp("#{@FILE_EXTENTION}").capitalize}\n"
  end
end

class NoDefaultLangError < Exception
end
