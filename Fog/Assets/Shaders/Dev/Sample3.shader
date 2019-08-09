﻿Shader "Sample/Dev/Sample3"
{
	Properties
	{
		_Strength ("Strength", float) = 1.0
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float3 worldPosition : TEXCOORD2;
				float4 vertex : SV_POSITION;
			};

			float _Strength;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.worldPosition = mul(unity_ObjectToWorld, v.vertex);
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				float distance = length(i.worldPosition - _WorldSpaceCameraPos);
				fixed4 color = fixed4(1.0, 1.0, 0.0, 1.0);
				float a = 1.0 - exp(-_Strength * distance);
				color = lerp(color, unity_FogColor, a);
				return color;
			}
			ENDCG
		}
	}
}
