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
            
            float circle(float2 st)
            {
                return step(0.3, distance(0.5, st));
            }
            
            fixed4 frag(v2f i): SV_Target
            {
                // 歪みの計算
                float x = 2 * i.uv.y + sin(_Time.y * 5);
                float distort = sin(_Time.y * 10) * 0.1 * sin(5 * x) * ( - (x - 1) * (x - 1) + 1);
                // 座標を歪ませる
                i.uv.x += distort;
                // RGB ごとに少しずつ座標をずらす
                return float4(circle(i.uv - float2(0, distort) * 0.3),
                circle(i.uv + float2(0, distort) * 0.3),
                circle(i.uv + float2(distort, 0) * 0.3),
                1);
            }
            ENDCG
            
        }
    }
}
