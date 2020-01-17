BLACK_KING = "\u265A".encode('utf-8')
BLACK_QUEEN = "\u265B".encode('utf-8')
BLACK_KNIGHT = "\u265E".encode('utf-8')
BLACK_BISHOP = "\u265D".encode('utf-8')
BLACK_PAWN = "\u265F".encode('utf-8')
BLACK_ROOK = "\u265C".encode('utf-8')
WHITE_KING = "\u2654".encode('utf-8')
WHITE_QUEEN = "\u2655".encode('utf-8')
WHITE_KNIGHT = "\u2658".encode('utf-8')
WHITE_BISHOP = "\u2657".encode('utf-8')
WHITE_PAWN = "\u2659".encode('utf-8')
WHITE_ROOK = "\u2656".encode('utf-8')

class Board
    def initialize
        @grid = Array.new(8) { Array.new(8, " ") }
        @white_graveyard = Hash.new
        @black_graveyard = Hash.new
        @white_graveyard.default = 0
        @black_graveyard.default = 0
        @white_turn = true
    end
end