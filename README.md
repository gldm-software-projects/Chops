# R-CHOPS 

<img src="/images/chops.jpg" alt="Representation of the six chops pieces" width="640"/>

## a simple board game between Chess and the Conway's game LIFE.

The game is based on an 8x8 board similar to chess, every player can make a move during his turn.

The game is over when there is no empty square on the chessboard, and wins the player with more pieces on the board.

A game can end even before the board is full if a player does not have any more pieces left.

*This is a Ruby implementation of the CHOPS game.*

---------------------
## Pieces

Each player starts with eight pieces: two Birds, two Spears, a Sword, a Snake, a Tree, and a Shield.

The pieces do not move on the board but replicate. Each piece has its own replication mode.
In the following figure we see the replication rules for every piece, let's assume the piece is oriented from the top of the screen towards the bottom of it.

![Rules for replication of the pieces](/images/rules_00.png "Replication rules")

For each square of the replica:
- If it is empty → a new piece is created
- If it contains an ally → nothing happens
- If it contains an enemy → the conflict rule applies
	- If the attacker wins → the defender is removed and the replica is created
	- If the attacker loses → nothing happens

### Conflict

|Attacker → / Defender ↓ |	Spear|Sword|Snake|Tree|Shield|Bird|
|------------------------|-----|----|-----|-----|-----|-----|
|Spear	|✔️	|✔️	|❌	|❌	|❌	|✔️|
|Sword	|✔️	|✔️	|✔️	|✔️	|❌	|✔️|
|Snake	|✔️	|✔️	|✔️	|❌	|❌	|✔️|
|Tree	|✔️	|❌	|✔️	|✔️	|❌	|❌|
|Shield	|❌	|❌	|❌	|✔️	|✔️	|❌|
|Bird	|✔️	|✔️	|✔️	|✔️	|✔️	|✔️|

✔️ = the attacker wins
❌ = the attacker loses

---------------------
## How to play

You'll need a Ruby interpreter. 
Clone the repository or download the code, move in the code directory then run the game by typing:
```ssh
ruby game.rb
```

![Run the game](/images/ss_00.png "Run")

The game welcomes you with a brief description of the pieces and a representation of the starting chessboard.

![Starting](/images/ss_01.png "Starting")

You can move selecting a square in the chessboard: input row and column as integer, separated by a space.
The games ask you to choose a move (some pieces can have multiple options). 
Select a move by typing its number.

![Interacting with the game](/images/ss_02.png "Playing")

After your move, the computer will make its move then prompt back for your next move.

The game ends when there is no empty square on the board.

![End of the game](/images/ss_04.png "Endgame")

### Saving and loading

The game allows you to save a game (input "S" when it's your turn) and load it back (input "L").

---------------------
## Developments note

The game is in an early stage, many things are missing:
- fine-tuning of the rules
- allow a human-VS-human match
- a graphical user interface

<img src="/images/sample_board.jpg" alt="Sample of a possible GUI for the game" width="400"/>

