using UnityEngine;
using System.Collections;

public class PinHoleController : MonoBehaviour {
	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {
		var pinPos = new Vector4(Input.mousePosition.x / Screen.width, Input.mousePosition.y / Screen.height, 0f);
		renderer.material.SetVector("_HolePos", pinPos);
	}
}
