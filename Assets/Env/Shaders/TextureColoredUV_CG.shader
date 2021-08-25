Shader "Custom/Texture Colored UV (CG)"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("Src Blend", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("Dst Blend", Int) = 0
    }

    SubShader
    {
        Tags
		{
            "Queue" = "Transparent"
			"PreviewType" = "Plane"
		}

        Pass
        {
            Blend [_SrcBlend] [_DstBlend]

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
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;

            CBUFFER_START(UnityPerMaterial)
            CBUFFER_END

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                float4 color =  tex2D(_MainTex, i.uv) * float4(i.uv.x, i.uv.y, 0, 1);
                return color;
            }
            ENDCG
        }
    }
}
