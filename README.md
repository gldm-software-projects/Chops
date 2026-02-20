# Chops

![Representation of the six chops pieces](/images/chops.jpg "Chops pieces")

## a simple board game between Chess and the Conway's game LIFE.

The game is based on an 8x8 board similar to chess, every player can make a move during his turn.
The game is over when there is no empty square on the chessboard, and wins the player with more pieces on the board.
A game can end even before the board is full, if a player does not have any more piece left.

## Pieces

Each player starts with eight pieces: two Birds, two Spears, a Sword, a Snake, a Tree, and a Shield.

The pieces do not move on the board but replicate. Each piece has its own replication mode.

![Rules for replication of the pieces](/images/rules_00.png "Replication rules")

For each square of the replica:
- If it is empty → a new piece is created
- If it contains an ally → nothing happens
- If it contains an enemy → the conflict rule applies
	- If the attacker wins → the defender is removed and the replica is created
	- If the attacker loses → nothing happens

## Conflict

|Attacker → / Defender ↓ |	Spear|Sword|Snake|Tree|Shield|Bird|
|------------------------|-----|----|-----|-----|-----|-----|
|Spear	|✔️	|✔️	|❌	|❌	|❌	|✔️|
|Sword	|✔️	|✔️	|✔️	|✔️	|❌	|✔️|
|Snake	|✔️	|✔️	|✔️	|❌	|❌	|✔️|
|Tree	|✔️	|❌	|✔️	|✔️	|❌	|❌|
|Shield	|❌	|❌	|❌	|✔️	|✔️	|❌|
|Bird	|✔️	|✔️	|✔️	|✔️	|✔️	|✔️|

✔️ = l’attaccante vince
❌ = l’attaccante perde
