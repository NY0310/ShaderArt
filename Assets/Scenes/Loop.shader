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
            
            // 指定した大きさの四角を描く関数
            float box(float2 st, float size)
            {
                size = 0.5 + size * 0.5;
                st = step(st, size) * step(1.0 - st, size);
                return st.x * st.y;
            }
            
            
            fixed4 frag(v2f i): SV_Target
            {
                float n = 10;
                float2 st = frac(i.uv * n);
                return box(st,abs(sin(_Time.y * 3)));
            }
            ENDCG
            
        }
    }
}
