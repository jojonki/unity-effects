Shader "Custom/Chou" {
	Properties {
		_MainTex ("Particle Texture", 2D) = "white" {}
		_C1 ("color 1", Color) = (0.5,0.5,0.5,0.5)
		_C2 ("color 2", Color) = (0.5,0.5,0.5,0.5)
		_C3 ("color 3", Color) = (1,1,0,1)
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
			fixed4 _C1,_C2,_C3;
		
			struct v2f {
				float4 pos : POSITION;
				fixed4 col : COLOR;
				float2 uv : TEXCOORD0;
			};
			
			float sphere(float3 v){
				float t = 1;
				v = fmod(v+1000,1);
				t *= 1-distance(v,float3(0.5,0.5,0.5)*2);
				return t;
			}
			float2 rotate(float2 v, float angle, float3 center) {
				float sinX = sin (angle);
				float cosX = cos (angle);
				float sinY = sin (angle);
				float2x2 rotationMatrix = float2x2( cosX, -sinX, sinY, cosX);
				
				float2 retVal = v;
				retVal -= center;
				retVal = mul(rotationMatrix, retVal);
				retVal += center;
				
				return retVal;
			} 
			
			v2f vert (appdata_full v)
			{
			
				float time = _Time.y*(12+v.color.r*5) + v.color.r*10;
				float signX = sign(v.texcoord.x - 0.5);
				float rot = sign(v.texcoord.x - 0.5)*(sin(time - v.texcoord.y/2)*(0.75+pow(v.texcoord.x,2)))*PI/2;
						
				float sinX = sin (rot);
				float cosX = cos (rot);
				float sinY = sin (rot);
				float2x2 rotationMatrix = float2x2( cosX, -sinX, sinY, cosX);

				float size = 10.0;
				size = size*(1.2+sin(v.color.r*10)/2);
				
				float centX, centY, centZ = 0.0;
				centX = v.vertex.x + size * (v.texcoord.x - 0.5);
				centY = v.vertex.y;
				centZ = v.vertex.z + size * (v.texcoord.y - 0.5);
				float3 center = float3(centX, centY, centZ);
				
				v.vertex.xy = rotate(v.vertex.xy, rot, center);
				
//				v.vertex.xyz = rotateX(v.vertex.xyz, -v.color.g, center);
				v.vertex.yz = rotate(v.vertex.yz, -v.color.g, center);
				
				v.vertex.y += -sin(time-PI*0.5)/4;

				// color
				float3 wPos = mul(_Object2World, v.vertex).xyz;
				float angle = atan2(wPos.x, wPos.z)+_Time.x;
				_C2.rgb = lerp(_C2.rgb, fixed3(0.5,1,0.5), v.color.b);
				v.color = lerp(_C1,_C2,sin(angle*5)+0.5) * v.color.a;
				v.color.rgb = lerp(v.color.rgb, _C3, sphere(v.vertex.xyz));
//				v.color.rgb = lerp(v.color.rgb, _C3, v.texcoord.x);
				v.color.a *= pow(saturate(length(v.vertex.xyz - center)/size+0.75),2);
				
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.col = v.color;
				o.uv = float2(v.texcoord.x, v.texcoord.y);
				return o;
			}
			
			half4 frag (v2f i) : COLOR
			{
				half4 col = tex2D(_MainTex, i.uv);
				col.a = col.r * i.col.a;
				col.a *= 2*col.a;
				col.rgb = i.col.rgb;
				
				return col;
			}
			
			ENDCG
		}
	}
}