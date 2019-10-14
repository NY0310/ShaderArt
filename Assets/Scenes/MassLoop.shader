Shader "Hidden/DistanceField"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" { }
    }
    SubShader
    {
        // No culling or depth
        Pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            struct appdata
            {
                float4 vertex: POSITION;
                float2 uv: TEXCOORD0;
            };
            
            struct v2f
            {
                float2 uv: TEXCOORD0;
                float4 vertex: SV_POSITION;
            };
            
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            
            sampler2D _MainTex;
            
            float wave(float2 st,float n)
            {
                st = (floor(st * n) + 0.5) / n;
                float d = distance(0.5, st);
                return(1 + sin(d * 3 - _Time.y * 3)) * 0.5;
            }
            
            
            
            fixed4 frag(v2f i): SV_Target
            {
                float n = 10;
                return wave(i.uv,n);
            }
            ENDCG
            
        }
    }
}
