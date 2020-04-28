# RA, 2020-04-14

# Problem description
# https://bit.ly/sci-wri-20200414-foobar

from numpy import add
from itertools import product, count


def solution(src, dst):
	"""
	Least number of knight moves from src to dst.

	The squares on the chessboard are encoded
	row-wise as consecutive integers 0, 1, 2, ...

	Args:
		src (int): Initial position of the knight.
		dst (int): Desired position.

	Returns:
		Number of steps from src to dst.
	"""

	# Dimensions of the chess board
	(h, w) = (8, 8)

	# Convert sequential index -> 2d-coordinates
	src = (src // w, src % w)
	dst = (dst // w, dst % w)

	# If x fell off the board, convert it to None
	def gravity(x):
		return tuple(x) if ((0 <= x[0] < h) and (0 <= x[1] < w)) else None

	# Prevent infinite loop
	assert gravity(src)
	assert gravity(dst)

	# The ways of the knight: 2+1 or 1+2
	knight_moves = set(product([-2, 2], [-1, 1])) | set(product([-1, 1], [-2, 2]))

	# Enumerate places reachable from the frontier set in one move
	# Actually, no need to check the validity of the 2d-coordinate
	def explore(places):
		for x in places:
			if x:
				for move in knight_moves:
					yield gravity(add(x, move))

	# Initial condition
	(visited, seenext) = ({None}, {src})

	# Dijkstra's shortest-path search
	for nsteps in count(0, 1, ):
		visited = visited | seenext
		seenext = set(explore(seenext)) - visited
		if dst in visited:
			return nsteps


if (__name__ == '__main__'):
	assert (solution(19, 36) == 1)
	assert (solution(0, 1) == 3)
	print("All passed!")
