Shader "Custom/Basic (HLSL)"
{
    SubShader
    {
        Tags
		{
			"PreviewType" = "Plane"
		}

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
            };


            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                float4 color = float4(1, 1, 1, 1);
                return color;
            }
            ENDHLSL
        }
    }
}
