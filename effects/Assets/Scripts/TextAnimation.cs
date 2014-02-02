using UnityEngine;
using System.Collections;

public class TextAnimation : MonoBehaviour {

	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {
		gameObject.transform.Rotate(new Vector3(0f, Time.deltaTime * 50f, 0f));
	}
}
