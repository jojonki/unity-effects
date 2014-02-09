Shader "Custom/VertexRot" {
	Properties {
		_MainTex ("Particle Texture", 2D) = "white" {}
	}
	
	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha 
	
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
				
			#include "UnityCG.cginc"
			#define PI 3.14159265359
			
			sampler2D _MainTex;
		
			struct v2f {
				float4 pos : POSITION;
				fixed4 col : COLOR;
				float2 uv : TEXCOORD0;
			};
			
			v2f vert (appdata_base v)
			{
				float _RotationSpeed = 2.0;
				float rnd = 2.0 * PI * (1.0 + sin(_Time.x * 50.0)) * 0.5;
				float sinX = sin ( _RotationSpeed * _Time.z );
				float cosX = cos ( _RotationSpeed * _Time.z );
				float sinY = sin ( _RotationSpeed * _Time.z );
				float2x2 rotationMatrix = float2x2( cosX, -sinX, sinY, cosX);

				float size =10.0 ;
				float centX = v.vertex.x + size * (v.texcoord.x - 0.5);
				float centZ = v.vertex.z + size * (v.texcoord.y - 0.5);
				float3 center = float3(centX, 0.0, centZ);
				v.vertex.xyz -= center;
				v.vertex.xz = mul(rotationMatrix, v.vertex.xz);
//				v.vertex.xy = mul(rotationMatrix, v.vertex.xy);
//				v.vertex.yz = mul(rotationMatrix, v.vertex.yz);
				v.vertex.xyz += center;


				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = float2(v.texcoord.x, v.texcoord.y);
				return o;
			}
			
			half4 frag (v2f i) : COLOR
			{
				half4 col = tex2D(_MainTex, i.uv);
				
				return col;
			}
			ENDCG
		}
	}
}