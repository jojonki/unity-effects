Shader "Custom/PinHole" {
	Properties {
		_HoleSize("Hole Size", float) = 0.1
		_BlurThick("Blur Thick", float) = 0.1
		_HolePos("Hole vector", Vector) = (0.5, 0.5, 1.0, 1.0)
		_Color ("Color", Color) = (0.0,0.0,0.0,1.0)
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
			
			float _HoleSize;
			float _BlurThick;
			fixed4 _HolePos;
			fixed4 _Color;
		
			struct v2f {
				float4 pos : POSITION;
				float2 uv : TEXCOORD0;
			};
			
			v2f vert (appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = float2(v.texcoord.x, v.texcoord.y);
				return o;
			}
			
			half4 frag (v2f i) : COLOR
			{
				half4 col = _Color;
				float2 pos = i.uv;

				// consider material resolution
				pos.y -= 0.5;
				pos.y *= (9.0 / 16.0);
				pos.y += 0.5;
				
				float dist = distance(pos, float2(_HolePos.x, _HolePos.y));
				if(dist < _HoleSize) {
					clip(-1.0);
				} else if(dist < _HoleSize + _BlurThick){
					col.a = (dist - _HoleSize) * 10.0;
					col.a = pow(col.a, 2.0);
				}
				
				return col;
			}
			
			ENDCG
		}
	}
}

