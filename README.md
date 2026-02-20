# Chops
a simple board game between Chess and the Conway's game LIFE.

For each square of the replica:
- If it is empty → a new piece is created
- If it contains an ally → nothing happens
- If it contains an enemy → the conflict rule applies
	- If the attacker wins → the defender is removed and the replica is created
	- If the attacker loses → nothing happens
