using UnityEngine;
using System.Collections;

public class Mic : MonoBehaviour {
	public float sensitivity = 100;
	public float loudness = 0;
	private float lastLoudness = 0;
	
	public GameObject DebugObj;
	
	// Use this for initialization
	void Start () {
		audio.clip = Microphone.Start(null, true, 10, 44100);
		audio.loop = true; // Set the AudioClip to loop
		audio.mute = true; // Mute the sound, we don't want the player to hear it
		while (!(Microphone.GetPosition(null) > 0)) { } // Wait until the recording has started
		audio.Play(); // Play the audio source!
	}
	
	// Update is called once per frame
	void Update () {
	    lastLoudness = loudness;
	    loudness = lastLoudness * 0.5f + GetAveragedVolume() * sensitivity * 0.5f;
	    //loudness = GetAveragedVolume() * sensitivity;
		
//		DebugObj.transform.localScale = new Vector3(loudness, loudness, loudness);
	}
	
	float GetAveragedVolume() {
		float[] data = new float[256];
		float a = 0.0f;
		audio.GetOutputData(data, 0);
		foreach (float s in data)
		{
			a += Mathf.Abs(s);
		}
		return a / 256.0f;
	}
}
