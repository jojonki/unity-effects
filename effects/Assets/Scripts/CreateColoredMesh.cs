using UnityEngine;
using System.Collections;

public class CreateColoredMesh : MonoBehaviour {

	void Start () {
		var meshFilter = gameObject.AddComponent<MeshFilter>();
		if (meshFilter == null) return;
		Mesh mesh = CreateSimplePlane();
		meshFilter.mesh = mesh;

		ChangeSimplePlaneMeshColor();
	}
	
	void Update () {
	
	}

	private Mesh CreateSimplePlane() {

		Mesh mesh = new Mesh();
		mesh.name = "SimplePlane";
		Vector3[] vertices = new Vector3[] {
			new Vector3( 0.5f,  0.5f, 0.0f),
			new Vector3(-0.5f, -0.5f, 0.0f),
			new Vector3(-0.5f,  0.5f, 0.0f),
			new Vector3( 0.5f, -0.5f, 0.0f)
		};
		int[] triangles = new int[] {
			0, 1, 2,
			3, 1, 0
		};
		Vector2[] uv = new Vector2[] {
			new Vector2(1.0f, 1.0f),
			new Vector2(0.0f, 0.0f),
			new Vector2(0.0f, 1.0f),
			new Vector2(1.0f, 0.0f)
		};

		mesh.vertices = vertices;
		mesh.triangles = triangles;
		mesh.uv = uv;
		mesh.RecalculateNormals();
		mesh.RecalculateBounds();

		return mesh;
	}

	private void ChangeSimplePlaneMeshColor() {
		Mesh mesh = GetComponent<MeshFilter>().mesh;
		Vector3[] vertices = mesh.vertices;
		Color[] colors = new Color[vertices.Length];
		colors[0] = Color.red;
		colors[1] = Color.blue;
		colors[2] = Color.yellow;
		colors[3] = Color.green;

		mesh.colors = colors;
	}
}
