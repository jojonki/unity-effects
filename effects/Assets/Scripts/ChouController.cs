using UnityEngine;
using System.Collections;

public class ChouController : MonoBehaviour {

	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKey(KeyCode.C)) {
			var x = Input.mousePosition.x / Screen.width;
			x -= 0.5f;
			var y = Input.mousePosition.y / Screen.height;
			y -= 0.5f;

			renderer.material.SetFloat("_TargetX", x);
			renderer.material.SetFloat("_TargetY", y);
			Debug.Log(x + " , " + y);
		}
	}
}
