require 'pry'

#Disabled chess unicode symbols until I can figure out how
#to get it to display in my terminal properly (it shows "?"
#right now for all symbols).

=begin
BLACK_KING = "\u265a".encode('utf-8')
BLACK_QUEEN = "\u265b".encode('utf-8')
BLACK_KNIGHT = "\u265e".encode('utf-8')
BLACK_BISHOP = "\u265d".encode('utf-8')
BLACK_PAWN = "\u265f".encode('utf-8')
BLACK_ROOK = "\u265c".encode('utf-8')
WHITE_KING = "\u2654".encode('utf-8')
WHITE_QUEEN = "\u2655".encode('utf-8')
WHITE_KNIGHT = "\u2658".encode('utf-8')
WHITE_BISHOP = "\u2657".encode('utf-8')
WHITE_PAWN = "\u2659".encode('utf-8')
WHITE_ROOK = "\u2656".encode('utf-8')
=end

BLACK_KING = "BK"
BLACK_QUEEN = "BQ"
BLACK_KNIGHT = "BK"
BLACK_BISHOP = "BB"
BLACK_PAWN = "BP"
BLACK_ROOK = "BR"
WHITE_KING = "WK"
WHITE_QUEEN = "WQ"
WHITE_KNIGHT = "WK"
WHITE_BISHOP = "WB"
WHITE_PAWN = "WP"
WHITE_ROOK = "WR"

class Board

    def initialize
        @board = Array.new(8) { Array.new(8, " ") }
        self.new_board
        @white_graveyard = Hash.new
        @black_graveyard = Hash.new
        @white_graveyard.default = 0
        @black_graveyard.default = 0
        @white_turn = true
        @winner = false
    end

    def display_board
        y = 7
        x = 0
        puts ""
        print "   "
        print "---" * 10
        print "--"
        puts ""
        until y < 0
            print " #{y} "
            until x > 7
                if @board[x][y] == " "
                    print "| #{@board[x][y]}|"
                else
                    print "|#{@board[x][y].piece}|"
                end
                x += 1
            end
            puts ""
            print "   "
            print "---" * 10
            print "--"
            puts ""
            y -= 1
            x = 0
        end
        print "    a   b   c   d   e   f   g   h  "
        puts "\n\n"
    end

    def take_turn
    end

    private
    def new_board
        #white pieces
        @board[0][0], @board[7][0] = Rook.new("a1"), Rook.new("h1")
        @board[1][0], @board[6][0] = Knight.new("b1"), Rook.new("g1")
        @board[2][0], @board[5][0] = Bishop.new("c1"), Rook.new("f1")
        @board[3][0] = Queen.new("d1")
        @board[4][0] = King.new("e1")
        @board[0][1], @board[1][1] = Pawn.new("a2"), Pawn.new("b2")
        @board[2][1],  @board[3][1] = Pawn.new("c2"), Pawn.new("d2")
        @board[4][1], @board[5][1] = Pawn.new("e2"), Pawn.new("f2")
        @board[6][1],  @board[7][1] = Pawn.new("g2"), Pawn.new("h2")

        #black pieces
        @board[0][7], @board[7][7] = Rook.new("a8", false), Rook.new("h8", false)
        @board[1][7], @board[6][7] = Knight.new("b8", false), Knight.new("g8", false)
        @board[2][7], @board[5][7] = Bishop.new("c8", false), Bishop.new("f8", false)
        @board[3][7] = Queen.new("d8", false)
        @board[4][7] = King.new("e8", false)
        @board[0][6], @board[1][6] = Pawn.new("a7", false), Pawn.new("b7", false)
        @board[2][6],  @board[3][6] = Pawn.new("c7", false), Pawn.new("d7", false)
        @board[4][6], @board[5][6] = Pawn.new("e7", false), Pawn.new("f7", false)
        @board[6][6],  @board[7][6] = Pawn.new("g7", false), Pawn.new("h7", false)
    end
end

class King #King can move one square in any direction
    attr_accessor :tile, :valid_moves
    attr_reader :piece
    def initialize tile, white_piece=true
        @tile = tile
        @directions = ["right", "down-right", "down", "down-left", "left", "up-left", "up", "up-right"]
        @valid_moves = calculate_valid_moves(@tile, @directions)
        white_piece ? @piece = WHITE_KING : @piece = BLACK_KING
    end
end

class Queen 
    attr_accessor :tile
    attr_reader :piece
    def initialize tile, white_piece=true
        @tile = tile
        white_piece ? @piece = WHITE_QUEEN : @piece = BLACK_QUEEN
    end
end

class Knight
    attr_accessor :tile
    attr_reader :piece
    def initialize tile, white_piece=true
        @tile = tile
        white_piece ? @piece = WHITE_KNIGHT : @piece = BLACK_KNIGHT
    end
end

class Bishop
    attr_reader :piece
    attr_accessor :tile
    def initialize tile, white_piece=true
        @tile = tile
        white_piece ? @piece = WHITE_BISHOP : @piece = BLACK_BISHOP
    end
end

class Rook
    attr_accessor :tile
    attr_reader :piece
    def initialize tile, white_piece=true
        @tile = tile
        white_piece ? @piece = WHITE_ROOK : @piece = BLACK_BISHOP
    end
end

class Pawn
    attr_reader :piece
    attr_accessor :tile
    def initialize tile, white_piece=true
        @tile = tile
        white_piece ? @piece = WHITE_PAWN : @piece = BLACK_PAWN
    end
end

def calculate_valid_moves tile, directions, can_move_farther_than_one_square=false
    valid_moves = []
    directions_copy = directions
    if can_move_farther_than_one_square
        range = 8
    else
        range = 1
    end

    current_spot = tile_to_indices(tile)
    until range == 0
        until directions_copy.empty?
            case directions_copy.shift
            when "right"
                current_move = [(current_spot[0] + 1)*range, current_spot[1]]
                unless current_move[0] < 0 || current_move[0] > 7 || current_move[1] < 0 || current_move[1] > 7
                    valid_moves << current_move
                end
            when "down-right" 
                current_move = [(current_spot[0] + 1)*range, (current_spot[1] - 1)*range]
                unless current_move[0] < 0 || current_move[0] > 7 || current_move[1] < 0 || current_move[1] > 7
                    valid_moves << current_move
                end
            when "down"
                current_move = [current_spot[0], (current_spot[1] - 1)*range] 
                unless current_move[0] < 0 || current_move[0] > 7 || current_move[1] < 0 || current_move[1] > 7
                    valid_moves << current_move
                end
            when "down-left"
                current_move = [(current_spot[0] - 1)*range, (current_spot[1] - 1)*range]
                unless current_move[0] < 0 || current_move[0] > 7 || current_move[1] < 0 || current_move[1] > 7
                    valid_moves << current_move
                end
            when "left"
                current_move = [(current_spot[0] - 1)*range, current_spot[1]]
                unless current_move[0] < 0 || current_move[0] > 7 || current_move[1] < 0 || current_move[1] > 7
                    valid_moves << current_move
                end
            when "up-left"
                current_move = [(current_spot[0] - 1)*range, (current_spot[1] + 1)*range]
                unless current_move[0] < 0 || current_move[0] > 7 || current_move[1] < 0 || current_move[1] > 7
                    valid_moves << current_move
                end
            when "up" 
                current_move = [current_spot[0], (current_spot[1] + 1)*range]
                unless current_move[0] < 0 || current_move[0] > 7 || current_move[1] < 0 || current_move[1] > 7
                valid_moves << current_move
                end
            when "up-right"
                current_move = [(current_spot[0] + 1)*range, (current_spot[1] + 1)*range] 
                unless current_move[0] < 0 || current_move[0] > 7 || current_move[1] < 0 || current_move[1] > 7
                    valid_moves << current_move
                end
            end
        end
        range -= 1
        directions_copy = directions
    end
    valid_moves
end

def tile_to_indices tile
    x, y = 0
    case tile[0]
    when "a"
        x = 0
    when "b"
        x = 1
    when "c"
        x = 2
    when "d"
        x = 3
    when "e"
        x = 4
    when "f"
        x = 5
    when "g"
        x = 6
    when "h"
        x = 7
    end

    case tile[1]
    when "1"
        y = 0
    when "2"
        y = 1
    when "3"
        y = 2
    when "4"
        y = 3
    when "5"
        y = 4
    when "6"
        y = 5
    when "7"
        y = 6
    when "8"
        y = 7
    end
    return [x,y]
end

def indices_to_tile x, y
    tile = ""
    case x
    when 0
        tile << "a"
    when 1
        tile << "b"
    when 2
        tile << "c"
    when 3
        tile << "d"
    when 4
        tile << "e"
    when 5
        tile << "f"
    when 6
        tile << "g"
    when 7
        tile << "h"
    end

    case y
    when 0
        tile << "1"
    when 1
        tile << "2"
    when 2
        tile << "3"
    when 3
        tile << "4"
    when 4
        tile << "5"
    when 5
        tile << "6"
    when 6
        tile << "7"
    when 7
        tile << "8"
    end
    tile
end

game = Board.new
game.display_board