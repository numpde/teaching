import math

from typing import List, Set


def build_neighbour_map() -> List[Set[int]]:
    """ Build the list of sets of neighbours. """
    steps = [(2, 1), (1, 2)]
    signed_steps = [(h*s1, v*s2) for s1 in [-1, 1] for s2 in [-1, 1] for h, v in steps]

    return [set(filter(lambda ix: 0 <= ix <= 63, (n + 8*h + v for h,v in signed_steps))) for n in range(64)]


def calculate_distance_dijkstra(source: int, target: int, neighbour_map: List[Set[int]]):
    """ Calculate the distance between source and target assuming that we have a neighbour_map containing the sets of neighbours. """
    distances = [math.inf for j in range(64)]
    distances[source] = 0

    unvisited = set(range(64))

    while unvisited:
        current = min(unvisited, key=lambda x: distances[x])

        for neighbour in (neighbour_map[current] & unvisited):
            distances[neighbour] = min(distances[neighbour], distances[current] + 1)

        unvisited.remove(current)
        if current == target:
            return distances[target]


def answer(source: int, target: int) -> int:
    neighbour_map = build_neighbour_map()
    return calculate_distance_dijkstra(source, target, neighbour_map)


if __name__ == '__main__':
    import sys

    try:
        print(answer(int(sys.argv[1]), int(sys.argv[2])))
    except KeyError:
        print('Usage:', sys.argv[0], 'source', 'target')
    except ValueError:
        print('Usage:', sys.argv[0], 'source', 'target')
