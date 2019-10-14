Shader "Hidden/DistanceField"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            #define PI 3.14159265359

            fixed4 frag (v2f i) : SV_Target
            {
                half2 st = 0.5 - i.uv;
                float a = atan2(st.y,st.x);
                float d = min(abs(cos(a * 2.5)) + 0.4,abs(sin (a * 2.5)) + 1.1) * 0.32;
                float r = length(st);
                return step(r,d);
            }
            ENDCG
        }
    }
}
