﻿Shader "TressFX/HairShadowShader"
{
	Properties
	{
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		
		// Pass to render object as a shadow caster
		/*Pass
		{
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
	            
			#include "UnityCG.cginc"
			
			StructuredBuffer<float3> g_HairVertexPositions;

			struct v2f
			{ 
				float4 pos : SV_POSITION;
			};

			v2f vert(appdata_base input)
			{
				float3 vertexPosition = g_HairVertexPositions[(int)input.vertex.x];
	            
	            v2f o;
	            
		        o.pos = mul(UNITY_MATRIX_MVP, float4(vertexPosition.xyz, 1));
		        
				return o;
			}

			float4 frag( v2f i ) : COLOR
			{
				return float4(1,0,0,1);
			}
			ENDCG
		}*/
		
		// Pass to render object as a shadow caster
		Pass
		{
			Name "ShadowCaster"
			Tags { "LightMode" = "ShadowCaster" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_shadowcaster
	            
			#include "UnityCG.cginc"
			
			StructuredBuffer<float3> g_HairVertexPositions;

			struct v2f
			{ 
				V2F_SHADOW_CASTER;
			};

			v2f vert(appdata_base input)
			{
				float3 vertexPosition = g_HairVertexPositions[(int)input.vertex.x];
	            
		        appdata_base v;
		        v.vertex = float4(vertexPosition.xyz, 1);
	            
	            v2f o;
	            
				TRANSFER_SHADOW_CASTER(o)
				return o;
			}

			float4 frag( v2f i ) : COLOR
			{
				SHADOW_CASTER_FRAGMENT(i)
			}
			ENDCG
		}
	} 
}