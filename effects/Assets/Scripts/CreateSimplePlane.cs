using UnityEngine;
using UnityEditor;
using System.Collections;

public class CreateSimplePlane : MonoBehaviour {
	void Start() {
		Create ();
	}

	[MenuItem("MyTools/Create Simple Plane")]
	static void Create()
	{
		GameObject obj = new GameObject("SimplePlane");
		MeshFilter meshFilter = obj.AddComponent<MeshFilter>();
		MeshRenderer meshRenderer = obj.AddComponent<MeshRenderer>();
		Mesh m = (Mesh)AssetDatabase.LoadAssetAtPath("Assets/SimplePlane.asset", typeof(Mesh));
		if(m == null)
		{
			m = new Mesh();
			m.name = "SimplePlane";
			Vector3[] vertices = new Vector3[]
			{
				new Vector3( 0.5f,  0.5f, 0.0f),
				new Vector3(-0.5f, -0.5f, 0.0f),
				new Vector3(-0.5f,  0.5f, 0.0f),
				new Vector3( 0.5f, -0.5f, 0.0f)
			};
			int[] triangles = new int[]
			{
				0, 1, 2,
				3, 1, 0
			};
			Vector2[] uv = new Vector2[]
			{
				new Vector2(1.0f, 1.0f),
				new Vector2(0.0f, 0.0f),
				new Vector2(0.0f, 1.0f),
				new Vector2(1.0f, 0.0f)
			};
			m.vertices = vertices;
			m.triangles = triangles;
			m.uv = uv;
			m.RecalculateNormals();
			
			AssetDatabase.CreateAsset(m, "Assets/SimplePlane.asset");
			AssetDatabase.SaveAssets();
		}
		meshFilter.sharedMesh = m;
		m.RecalculateBounds();
	}
}