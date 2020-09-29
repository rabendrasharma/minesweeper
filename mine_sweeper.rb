#!/bin/ruby

require 'json'
require 'stringio'

#
# Complete the 'show_board' function below.
#
# The function is expected to return a STRING.
# The function accepts following parameters:
#  1. INTEGER height
#  2. INTEGER width
#  3. INTEGER num_mines
#

### --- CLASS BEGIN ###
class Tile
    attr_accessor :mine, :neighbours, :position
    def initialize position
        @flagged, @revealed, @bomb = false, false, false
        @position = position
        @mine = false
        @neighbours = []
    end
    
    def bomb?
      @bomb
    end
  
    def flagged?
      @flagged
    end
  
    def revealed?
      @revealed
    end
end

class Board
    attr_reader :board
    COORDINATES = [[1,0], [-1, 0], [0, 1], [0, -1]]
    def initialize height, width, num_mines
        @board = []
        (0...height).each do |h|
            inner_arr = []
            (0...width).each do |w|
                inner_arr << Tile.new([h, w])
            end
            @board << inner_arr
        end
        @board.flatten.shuffle.take(num_mines)&.each do |tile|
            tile.mine = true
        end
        @board.each do |row|
            row.each do |tile|
                COORDINATES.each do |x, y|
                    x_axis = tile.position[0]+x
                    y_axis = tile.position[0]+y
                    tile.neighbours << board[x_axis, y_axis] if x_axis.between?(0, height-1) && y_axis.between?(0, width-1)
                end
            end
        end
    end
    
    def [](position)
        board[position[0], position[1]]
    end
    def display_matix
        puts "***Matrix Display***"
        @board.each do |row|
            tiles_str = ""
            row.each do |tile|
               tiles_str += "_ "
            end
            puts "#{tiles_str}"
        end
    end
    def play
    end
    
end


### --- CLASS END ###

def show_board(height, width, num_mines)
   board =  Board.new(height, width, num_mines)
   board.display_matix
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

height = 5

width = 5

num_mines = 4

result = show_board height, width, num_mines

fptr.write result
fptr.write "\n"

fptr.close()
