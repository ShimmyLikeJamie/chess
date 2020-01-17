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
        @board = Array.new(8) { Array.new(8, " ") }
        @board = new_board(@board)
        @white_graveyard = Hash.new
        @black_graveyard = Hash.new
        @white_graveyard.default = 0
        @black_graveyard.default = 0
        @white_turn = true
    end

    def display_board

    end

    private
    def new_board
        #white pieces
        board[0][0], board[7][0] = Rook.new("a1"), Rook.new("h1")
        board[1][0], board[6][0] = Knight.new("b1"), Rook.new("g1")
        board[2][0], board[5][0] = Bishop.new("c1"), Rook.new("f1")
        board[3][0] = Queen.new("d1")
        board[4][0] = King.new("e1")
        board[0][1], board[1][1] = Pawn.new("a2"), Pawn.new("b2")
        board[2][1],  board[3][1] = Pawn.new("c2"), Pawn.new("d2")
        board[4][1], board[5][1] = Pawn.new("e2"), Pawn.new("f2")
        board[6][1],  board[7][1] = Pawn.new("g2"), Pawn.new("h2")

        #black pieces
        board[0][7], board[7][7] = Rook.new("a8", false), Rook.new("h8", false)
        board[1][7], board[6][7] = Knight.new("b8", false), Knight.new("g8", false)
        board[2][7], board[5][7] = Bishop.new("c8", false), Bishop.new("f8", false)
        board[3][7] = Queen.new("d8", false)
        board[4][7] = King.new("e8", false)
        board[0][6], board[1][6] = Pawn.new("a7", false), Pawn.new("b7", false)
        board[2][6],  board[3][6] = Pawn.new("c7", false), Pawn.new("d7", false)
        board[4][6], board[5][6] = Pawn.new("e7", false), Pawn.new("f7", false)
        board[6][6],  board[7][6] = Pawn.new("g7", false), Pawn.new("h7", false)
    end
end

class King
    attr_accessor :tile
    def initialize tile, white_piece=true
        @tile = tile
        white_piece ? @piece = WHITE_KING : @piece = BLACK_KING
    end
end

class Queen
    attr_accessor :tile
    def initialize tile, white_piece=true
        @tile = tile
        white_piece ? @piece = WHITE_QUEEN : @piece = BLACK_QUEEN
    end
end

class Knight
    attr_accessor :tile
    def initialize tile, white_piece=true
        @tile = tile
        white_piece ? @piece = WHITE_KNIGHT : @piece = BLACK_KNIGHT
    end
end

class Bishop
    attr_accessor :tile
    def initialize tile, white_piece=true
        @tile = tile
        white_piece ? @piece = WHITE_BISHOP : @piece = BLACK_BISHOP
    end
end

class Rook
    attr_accessor :tile
    def initialize tile, white_piece=true
        @tile = tile
        white_piece ? @piece = WHITE_ROOK : @piece = BLACK_BISHOP
    end
end

class Pawn
    attr_accessor :tile
    def initialize tile, white_piece=true
        @tile = tile
        white_piece ? @piece = WHITE_PAWN : @piece = BLACK_PAWN
    end
end