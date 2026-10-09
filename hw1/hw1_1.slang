[shader("compute")]
[numthreads(8, 8, 1)]
void compute_main(uint2 tid : SV_DispatchThreadID,
                  uniform float2 center,
                  uniform float radius,
                  uniform float3 color,
                  RWTexture2D<float4> image) {
    uint width, height;
    image.GetDimensions(width, height);
    if (tid.x >= width || tid.y >= height) {
        return;
    }

    image[tid] = float4(0.5, 0.5, 0.5, 1.0);
    // TODO: your code here
	center.y = height - center.y;	// bc shader codes y top to bottom
    float dist_x = abs(center.x - (tid.x + 0.5));
    float dist_y = abs(center.y - (tid.y + 0.5));
    float dist = sqrt( (dist_x * dist_x) + (dist_y * dist_y) );
    if (dist <= radius) {
        image[tid] = float4(color, 1.0);
    }
}
