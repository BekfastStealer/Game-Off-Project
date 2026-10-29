class_name Directions
extends Object


enum Direction {
	UP,
	LEFT,
	DOWN,
	RIGHT,
}
const DIRECTION_VECTORS: Array[Vector2i] = [Vector2.UP, Vector2.LEFT, Vector2.DOWN, Vector2.RIGHT]


static func to_vector(direction: Direction) -> Vector2i:
	return DIRECTION_VECTORS[direction]
