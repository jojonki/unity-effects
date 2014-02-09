Shader "Custom/TextureRot" {
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
				float sinX = sin ( _RotationSpeed * _Time.z );
				float cosX = cos ( _RotationSpeed * _Time.z );
				float sinY = sin ( _RotationSpeed * _Time.z );
				float2x2 rotationMatrix = float2x2( cosX, -sinX, sinY, cosX);
				v.texcoord.xy -= 0.5;
				v.texcoord.xy = mul ( v.texcoord.xy, rotationMatrix );
				v.texcoord.xy += 0.5;
				
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = float2(v.texcoord.x, v.texcoord.y);
				return o;
			}
			
			half4 frag (v2f i) : COLOR
			{
				half4 col = tex2D(_MainTex, i.uv);
				if(i.uv.x < 0.0) clip(-1.0);
				if(i.uv.x > 1.0) clip(-1.0);
				if(i.uv.y < 0.0) clip(-1.0);
				if(i.uv.y > 1.0) clip(-1.0);
				
				return col;
			}
			ENDCG
		}
	}
}