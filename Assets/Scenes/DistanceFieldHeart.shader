Shader "Hidden/DistanceFieldHeat"
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
            
            float heart(float2 st)
            {
                // 位置とか形の調整
                st = (st - float2(0.5, 0.38)) * float2(2.1, 2.8);           
                return pow(st.x, 2) + pow(st.y - sqrt(abs(st.x)), 2);
            }
                     
            fixed4 frag(v2f i): SV_Target
            {
                float d = heart(i.uv);
                return step(d,abs(sin(d * 8 - _Time.w * 2)));
            }
            ENDCG
        }
    }
}
