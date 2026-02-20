## Chops

# a simple board game between Chess and the Conway's game LIFE.

![Representation of the six chops pieces](/images/chops.jpg "Chops pieces")

The game is based on an 8x8 board similar to chess.
Each player starts with eight pieces: two Birds, two Spears, a Sword, a Snake, a Tree, and a Shield.

The pieces do not move on the board but replicate. Each piece has its own replication mode.
![Rules for replication of the pieces](/images/rules_00.png "Replication rules")

For each square of the replica:
- If it is empty → a new piece is created
- If it contains an ally → nothing happens
- If it contains an enemy → the conflict rule applies
	- If the attacker wins → the defender is removed and the replica is created
	- If the attacker loses → nothing happens
