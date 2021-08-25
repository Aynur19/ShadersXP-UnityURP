Shader "Custom/Texture Colored (HLSL)"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1, 1, 1, 1)
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

            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment Fragment

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            TEXTURE2D_X(_MainTex);
            SAMPLER(sampler_MainTex);
            
            CBUFFER_START(UnityPerMaterial)
                float4 _Color;
            CBUFFER_END

            Varyings Vert(Attributes input)
            {
                Varyings output;
                output.positionCS = TransformObjectToHClip(input.positionOS.xyz);
                output.uv = input.uv;
                return output;
            }

            float4 Fragment(Varyings input) : SV_Target
            {
                float4 color = SAMPLE_TEXTURE2D_X(_MainTex, sampler_MainTex, input.uv) * _Color;
                return color;
            }
            ENDHLSL
        }
    }
}
