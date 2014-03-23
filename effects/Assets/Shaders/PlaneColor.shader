Shader "Custom/PlaneColor" {
	Properties {
		_Color ("Color", Color) = (1, 1, 1, 1)
	}
	SubShader {
		Tags { "RenderType"="Transparent" }
        Blend SrcAlpha One
        Pass {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            struct v2f {
                float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
            };
            
            float4 _Color;
            
            v2f vert(appdata_base v)
            {	
            	if(v.vertex.x > (sin(_Time.z * 2.0) + 1.0) * 0.5) {
	            	float sinX = sin(_Time.z);
	            	float sinY = sin(_Time.z);
	            	float cosX = cos(_Time.z);
	            	float2x2 rotationMatrix = float2x2( cosX, -sinX, sinY, cosX);
					v.vertex.xy = mul(rotationMatrix, v.vertex.xy);
				}
				
                v2f o;
                o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
				o.uv = float2(v.texcoord.x, v.texcoord.y);
                return o;
            }
            
            half4 frag (v2f i) : COLOR
            {
            	half4 col = _Color;
            	if(i.uv.x > (sin(_Time.z) + 1.0) * 0.5) {
            		col.r *= sin(_Time.y * 2.4);
            		col.g = 0.0;
            		col.b = 0.0;
            	}
                return col;
            }
            ENDCG
        }
	} 
	FallBack Off
}