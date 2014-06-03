using UnityEngine;
using System.Collections;

public class MoveAnimation : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.U)) {
			iTween.MoveTo(gameObject, iTween.Hash("y", 5f, "time", 0.1f, "easeType", "easeOutSine"));
		} else if(Input.GetKey(KeyCode.LeftArrow)) {
			gameObject.transform.localPosition = gameObject.transform.localPosition + new Vector3(-0.1f, 0f);
		} else if(Input.GetKey(KeyCode.RightArrow)) {
			gameObject.transform.localPosition = gameObject.transform.localPosition + new Vector3(0.1f, 0f);
		} else if(Input.GetKey(KeyCode.UpArrow)) {
			gameObject.transform.localPosition = gameObject.transform.localPosition + new Vector3(0f, 0.1f);
		} else if(Input.GetKey(KeyCode.DownArrow)) {
			gameObject.transform.localPosition = gameObject.transform.localPosition + new Vector3(0f, -0.1f);
		}
//		gameObject.transform.localPosition = Input.mousePosition * 0.0.1f;
	}
}
