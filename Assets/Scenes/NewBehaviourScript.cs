using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode, RequireComponent (typeof (Renderer))]
public class NewBehaviourScript : MonoBehaviour {
    public Material mat;
    // Start is called before the first frame update
    void Start () {

    }

    // Update is called once per frame
    void Update () {

    }

    /// <summary>
    /// OnRenderImage is called after all rendering is complete to render image.
    /// </summary>
    /// <param name="src">The source RenderTexture.</param>
    /// <param name="dest">The destination RenderTexture.</param>
    void OnRenderImage (RenderTexture src, RenderTexture dest) {
        Graphics.Blit (null, dest, mat);
    }
}