extends MeshInstance3D

var stone: cell

var matrixX: int = 16
var matrixY: int = 16
var matrixZ: int = 16

var worldX: int = 0
var worldY: int = 0
var worldZ: int = 0

var cellMatrix: Array = []

var aMesh = ArrayMesh.new()
var UVs = PackedVector2Array()
var mat = StandardMaterial3D
var colour = Color(0.5, 0.5, 0.5)

var rng = RandomNumberGenerator.new()
var heightMap = FastNoiseLite.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var vertices := PackedVector3Array([
		Vector3(0,0,0),
		Vector3(1,0,0),
		Vector3(1,0,1),
	])
	
	var indicies := PackedInt32Array([
		0,1,2
	])
	
	var array = []
	array.resize(mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX] = vertices
	array[mesh.ARRAY_INDEX] = indicies
	
	aMesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
	
	mesh = aMesh
	initialiseChunk()
	pass
	
func initialiseChunk():
	heightMap.seed = rng.randi()
	heightMap.offset = Vector3(matrixX*worldX, matrixY*worldY, matrixZ*worldZ)
	heightMap.set_noise_type(FastNoiseLite.TYPE_VALUE_CUBIC)
	heightMap.set_frequency(0.03)
	heightMap.set_fractal_octaves(4)
	
	for x in matrixX:
		cellMatrix.append([])
		for y in matrixY:
			cellMatrix[x].append([])
			for z in matrixZ:
				var height = heightMap.get_noise_2d(x, z) * matrixY * 2
				cellMatrix[x][y].append(y < height)
	print(cellMatrix)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
