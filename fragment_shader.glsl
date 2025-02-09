#version 330 core

out vec4 FragColor;
in vec2  TexCoord;

uniform float u_time;
uniform vec2  u_resolution;
uniform vec3  u_mouse;

uniform float ro_x;
uniform float ro_y;
uniform float ro_z;

uniform float lt_x;
uniform float lt_y;
uniform float lt_z;

uniform float zoom_level;

#if 0
// Program running once per pixel
void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{
    // Output is a pixel color
    fragColor = vec4(0.675, 0.576, 0.89, 1.0);
} 
#endif

#if 0
void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    //        pixel coordinates , screen resolution (normalization)
    vec2 uv = fragCoord.xy / u_resolution.xy;
    
    fragColor = vec4(uv.x, 0.0, 0.0, 1.0);
} 
#endif

#if 0
void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    //        pixel coordinates , screen resolution (normalization)
    vec2 uv = fragCoord.xy / u_resolution.xy;
    
    fragColor = vec4(0.0, 0.0, uv.y, 1.0);
} 
#endif

#if 0
void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    //        pixel coordinates , screen resolution (normalization)
    vec2 uv = fragCoord.xy / u_resolution.xy;
    
    fragColor = vec4(uv.x, 0.0, uv.y, 1.0);
} 
#endif

#if 0
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/u_resolution.xy;
    vec3 col = cos(u_time+vec3(0,2.0,4.0));
    fragColor = vec4(col,1.0);
}
#endif

#if 0
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/u_resolution.xy;
    vec3 col = 0.5 + 0.5 * cos(u_time+vec3(0,2.0,4.0));
    fragColor = vec4(col,1.0);
}
#endif

#if 0
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/u_resolution.xy;
    vec3 col = 0.5 + 0.5*cos(u_time+uv.xyx+vec3(0,2,4));
    fragColor = vec4(col,1.0);
}
#endif

#if 0
void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{
    vec2 uv = fragCoord / u_resolution.xy;

    vec3 brightness = vec3(0.5,0.5,0.5);
    vec3 contrast   = vec3(0.5,0.5,0.5);
    vec3 cycle      = vec3(1.0,1.0,1.0);
    vec3 loc        = vec3(0.0,0.32,0.65);

    vec3 col = vec3(brightness + contrast * cos(6.2831 * (uv.x*cycle + loc))); 
    fragColor = vec4(col, 1.0);
}
#endif

#if 0
void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = fragCoord.xy / u_resolution.xy;

    float d = length(uv);

    fragColor = vec4(d,0.0,d, 1.0);
} 
#endif

#if 0
void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = fragCoord.xy / u_resolution.xy;

    uv.x -= 0.5;
    uv.y -= 0.5;

    float d = length(uv);

    fragColor = vec4(d,d,d, 1.0);
} 
#endif

#if 0
void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = fragCoord.xy / u_resolution.xy;

    uv.x -= 0.5;
    uv.y -= 0.5;

    uv.x *= u_resolution.x / u_resolution.y;

    float d = length(uv);

    // vec2 uv = (2.0*fragCoord.xy-u_resolution.xy)/u_resolution.y; 
    // float d = length(uv)*0.5;

    fragColor = vec4(d,d,d, 1.0);
} 
#endif

#if 0
void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = fragCoord.xy / u_resolution.xy;

    uv.x -= 0.5;
    uv.y -= 0.5;

    uv.x *= u_resolution.x / u_resolution.y;

    float d = length(uv);
    float c = d;

    float rad = 0.3;

    c = d < rad ? 1.0 : 0.0;

    fragColor = vec4(vec3(c), 1.0);
} 
#endif

#if 0
void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = fragCoord.xy / u_resolution.xy;

    uv.x -= 0.5;
    uv.y -= 0.5;

    uv.x *= u_resolution.x / u_resolution.y;

    float d  = length(uv);
    float r  = 0.4;
    float aa = 0.003;

    float c = smoothstep(r,r-aa, d);

    fragColor = vec4(vec3(c), 1.0);
} 
#endif

#if 0
float circle(vec2 uv, vec2 pos, float rad, float blur)
{
    uv.x -= 0.5;
    uv.y -= 0.5;

    uv.x *= u_resolution.x / u_resolution.y;

    float d = length(uv-pos);

    float c = smoothstep(rad,rad-blur, d);

    return c;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = fragCoord.xy / u_resolution.xy;

    float c = circle(uv, vec2(0.2,-0.1), 0.1, 0.05);

    fragColor = vec4(vec3(c), 1.0);
} 
#endif

#if 0
float circle(vec2 uv, vec2 pos, float rad, float blur)
{
    uv.x -= 0.5;
    uv.y -= 0.5;

    uv.x *= u_resolution.x / u_resolution.y;

    float d = length(uv-pos);

    float c = smoothstep(rad,rad-blur, d);

    return c;
}

float circle_outline(vec2 uv, vec2 pos, float rad, float blur, float width)
{
    float c = circle(uv, pos, rad, blur);
    c -= circle(uv, pos, rad-width, blur);

    return c;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = fragCoord.xy / u_resolution.xy;

    float c = circle_outline(uv, vec2(0,0), 0.3, 0.002, 0.05);

    fragColor = vec4(vec3(c), 1.0);
} 
#endif

#if 0
float rectangle(vec2 uv, vec2 pos, vec2 dim)
{
    vec2 d = abs(uv-pos) - dim;
    float l = length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
    return 1.0 - step(0.0, l);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    float aspect = u_resolution.x / u_resolution.y;
    vec2 uv = (2.0*fragCoord.xy-u_resolution.xy)/u_resolution.y;
    uv.x *= aspect;

    float c = rectangle(uv, vec2(0.0, 0.0), vec2(0.3*aspect, 0.3));
    fragColor = vec4(vec3(c), 1.0);
} 
#endif 

#if 0
float rectangle(vec2 uv, vec2 pos, vec2 dim)
{
    vec2 d = abs(uv-pos) - dim;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
}

float rounded_rect(vec2 uv, vec2 pos, vec2 dim, float rad)
{
    float c = rectangle(uv, pos, dim) - rad;
    float aa = 0.003;
    c = 1 - smoothstep(-aa, aa, c);
    return c;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    float aspect = u_resolution.x / u_resolution.y;
    vec2 uv = (2.0*fragCoord.xy-u_resolution.xy)/u_resolution.y;
    uv.x *= aspect;

    float c = rounded_rect(uv, vec2(0.0,0.0), vec2(0.5*aspect, 0.2), 0.1) ;
    fragColor = vec4(vec3(c), 1.0);
} 
#endif 


#if 0

float dist_point_line(vec3 ro, vec3 rd, vec3 p)
{
    return length(cross(p-ro, rd))/length(rd);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = (2.0*fragCoord.xy-u_resolution.xy)/u_resolution.y; 

    // Camera , Z out of screen is positive
    vec3 ray_origin = vec3(0.0, 0.0, 2);      // point at which the camera is positioned
    vec3 ray_dir    = normalize(vec3(uv.x-ray_origin.x, uv.y-ray_origin.y, -2));

    vec3 pos = vec3(0.0,0.0,0.0+sin(u_time)); 

    float d    = dist_point_line(ray_origin, ray_dir, pos);
    float rad  = 0.2;
    float blur = 0.01;
    float c    = smoothstep(rad,rad-blur, d);

    fragColor = vec4(vec3(c),1.0);
} 

#endif

#if 0

float dist_point_line(vec3 ro, vec3 rd, vec3 p)
{
    return length(cross(p-ro, rd))/length(rd);
}

float DrawCircle(vec3 ro, vec3 rd, vec3 pp, float rad)
{
    float blur = 0.01;
    float d = dist_point_line(ro, rd, pp);
    return smoothstep(rad,rad-blur, d);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = (2.0*fragCoord.xy-u_resolution.xy)/u_resolution.y; 

    // Camera , Z out of screen is positive
    vec3 ray_origin = vec3(0.0, 0.0, 5.0);
    vec3 ray_dir    = normalize(vec3(uv.x, uv.y, 3.0)-ray_origin);

    float c = 0;
    c += DrawCircle(ray_origin, ray_dir, vec3(0.0,0.0,0.0), 0.05);
    c += DrawCircle(ray_origin, ray_dir, vec3(0.0,0.0,1.0), 0.05);
    c += DrawCircle(ray_origin, ray_dir, vec3(0.0,1.0,0.0), 0.05);
    c += DrawCircle(ray_origin, ray_dir, vec3(0.0,1.0,1.0), 0.05); 
    c += DrawCircle(ray_origin, ray_dir, vec3(1.0,0.0,0.0), 0.05);
    c += DrawCircle(ray_origin, ray_dir, vec3(1.0,0.0,1.0), 0.05);
    c += DrawCircle(ray_origin, ray_dir, vec3(1.0,1.0,0.0), 0.05);
    c += DrawCircle(ray_origin, ray_dir, vec3(1.0,1.0,1.0), 0.05);

    fragColor = vec4(vec3(c),1.0);
} 

#endif

#if 0

float dist_point_line(vec3 ro, vec3 rd, vec3 p)
{
    return length(cross(p-ro, rd))/length(rd);
}

float DrawCircle(vec3 ro, vec3 rd, vec3 pp, float rad)
{
    float blur = 0.01;
    float d = dist_point_line(ro, rd, pp);
    return smoothstep(rad,rad-blur, d);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = (2.0*fragCoord.xy-u_resolution.xy)/u_resolution.y; 

    // Camera , Z out of screen is positive
    vec3 ray_origin = vec3(4.0*sin(u_time),0.0, 3.0*cos(u_time));

    vec3 lookat = vec3(0.5);        // center of cube

    vec3 f = normalize(lookat - ray_origin);
    vec3 r = normalize(cross(vec3(0.0,1.0,0.0),f));
    vec3 u = normalize(cross(f,r));

    float zoom = 1.0;

    vec3 c = ray_origin + f*zoom;
    vec3 i = c + uv.x*r + uv.y*u;

    vec3 ray_dir = normalize(i-ray_origin);

    float d = 0;
    d += DrawCircle(ray_origin, ray_dir, vec3(0.0,0.0,0.0), 0.05);
    d += DrawCircle(ray_origin, ray_dir, vec3(0.0,0.0,1.0), 0.05);
    d += DrawCircle(ray_origin, ray_dir, vec3(0.0,1.0,0.0), 0.05);
    d += DrawCircle(ray_origin, ray_dir, vec3(0.0,1.0,1.0), 0.05); 
    d += DrawCircle(ray_origin, ray_dir, vec3(1.0,0.0,0.0), 0.05);
    d += DrawCircle(ray_origin, ray_dir, vec3(1.0,0.0,1.0), 0.05);
    d += DrawCircle(ray_origin, ray_dir, vec3(1.0,1.0,0.0), 0.05);
    d += DrawCircle(ray_origin, ray_dir, vec3(1.0,1.0,1.0), 0.05);

    fragColor = vec4(vec3(d),1.0);
} 

#endif


#if 0

#define MAX_STEPS       100
#define SURFACE_DIST    0.001
#define MAX_DIST        20.0

float map(in vec3 pos)
{
    // sphere             rad
    vec4 sphere = vec4(0,1,6,1);
    float ds = length(pos-sphere.xyz)-0.3;
    float dp = pos.y;
    float d = min(ds,dp);
    return d;
}

vec3 calcNormal(in vec3 pos)
{
    vec2 e = vec2(0.0001,0.0);
    return normalize(vec3(map(pos+e.xyy)-map(pos-e.xyy),
                          map(pos+e.yxy)-map(pos-e.yxy),
                          map(pos+e.yyx)-map(pos-e.yyx)));
}

float ray_march(vec3 ro, vec3 rd)
{
    float t = 0.0;
    for(int i = 0; i< MAX_STEPS; i++)
    {
        vec3 pos = ro + t*rd;
        float h = map(pos);
        t += h;
        if(h < SURFACE_DIST || t > MAX_DIST)
            break;
    }
    return t;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = (2.0*fragCoord.xy-u_resolution.xy)/u_resolution.y; 

    // Camera , Z out of screen is positive
    vec3 ray_origin = vec3(ro_x,ro_y,ro_z);

    vec3 lookat = vec3(0,1,6);        // center of cube

    vec3 f = normalize(lookat - ray_origin);
    vec3 r = normalize(cross(vec3(0.0,1.0,0.0),f));
    vec3 u = normalize(cross(f,r));

    float zoom = zoom_level;

    vec3 c = ray_origin + f*zoom;
    vec3 i = c + uv.x*r + uv.y*u;

    vec3 ray_dir = normalize(i-ray_origin);

    float d = ray_march(ray_origin, ray_dir);

    vec3 col = vec3(0.0);

    if(d < MAX_DIST){
        vec3 pos = ray_origin + d*ray_dir;
        vec3 norm = calcNormal(pos);

        vec3 sun_dir = normalize(vec3(0.8,0.4,0.8));
        float sun_diff = clamp(dot(norm, sun_dir),0.0,1.0);
        float sky_dif = clamp(0.5 + 0.5 * dot(norm,vec3(0.0,1.0,0.0)),0.0,1.0); 
        col = vec3(1.0,0.7,0.5)*sun_diff;
        col += vec3(0.0,0.1,0.25)*sky_dif;
    }
    fragColor = vec4(vec3(col),1.0);
}

#endif

#if 0
#define MAX_STEPS       100
#define SURFACE_DIST    0.001
#define MAX_DIST        20.0
#define GRID_SIZE       3      // Number of spheres along each dimension
#define SPACING         1.2    // Distance between sphere centers

float sphereDistance(vec3 pos, vec3 center, float radius)
{
    float ds = length(pos - center) - radius;
    float dp = pos.y;
    float d = min(ds,dp);
    return d;
}

float map(in vec3 pos)
{
    float d = MAX_DIST;  // Initialize with a large value

    for(int x = 0; x < GRID_SIZE; x++)
    {
        for(int y = 0; y < GRID_SIZE; y++)
        {
            for(int z = 0; z < GRID_SIZE; z++)
            {
                vec3 sphereCenter = vec3(x+0, y+2, z+3) * SPACING + vec3(-1.0) * SPACING * (GRID_SIZE - 1) / 2.0;
                float sphereRadius = 0.3;
                float distToSphere = sphereDistance(pos, sphereCenter, sphereRadius);
                d = min(d, distToSphere);
            }
        }
    }
    return d;
}

vec3 calcNormal(in vec3 pos)
{
    vec2 e = vec2(0.0001, 0.0);
    return normalize(vec3(
        map(pos + e.xyy) - map(pos - e.xyy),
        map(pos + e.yxy) - map(pos - e.yxy),
        map(pos + e.yyx) - map(pos - e.yyx)
    ));
}

float ray_march(vec3 ro, vec3 rd)
{
    float t = 0.0;
    for(int i = 0; i < MAX_STEPS; i++)
    {
        vec3 pos = ro + t * rd;
        float h = map(pos);
        t += h;
        if(h < SURFACE_DIST || t > MAX_DIST)
            break;
    }
    return t;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = (2.0 * fragCoord.xy - u_resolution.xy) / u_resolution.y; 

    vec3 ray_origin = vec3(ro_x, ro_y, ro_z);
    vec3 lookat = vec3(lt_x, lt_y, lt_z);

    vec3 f = normalize(lookat - ray_origin);
    vec3 r = normalize(cross(vec3(0.0, 1.0, 0.0), f));
    vec3 u = normalize(cross(f, r));

    float zoom = zoom_level;
    vec3 c = ray_origin + f * zoom;
    vec3 i = c + uv.x * r + uv.y * u;
    vec3 ray_dir = normalize(i - ray_origin);

    float d = ray_march(ray_origin, ray_dir);
    vec3 col = vec3(0.0);

    if(d < MAX_DIST)
    {
        vec3 pos = ray_origin + d * ray_dir;
        vec3 norm = calcNormal(pos);

        vec3 sun_dir = normalize(vec3(0.8, 0.4, 0.8));
        float sun_diff = clamp(dot(norm, sun_dir), 0.0, 1.0);
        float sky_dif = clamp(0.5 + 0.5 * dot(norm, vec3(0.0, 1.0, 0.0)), 0.0, 1.0); 
        col = vec3(1.0, 0.7, 0.5) * sun_diff;
        col += vec3(0.0, 0.1, 0.25) * sky_dif;
    }

    fragColor = vec4(col, 1.0);
}

#endif


#if 0
#define MAX_STEPS               100
#define SURFACE_DIST            0.001
#define MAX_DIST                20.0
#define GRID_SIZE               3
#define SPACING                 1.2
#define REFLECTION_STEPS        32
#define REFLECTION_INTENSITY    0.4

// Material properties
struct Material {
    vec3  albedo;
    float metallic;
    float roughness;
    float fresnel;
};

float sphereDistance(vec3 pos, vec3 center, float radius)
{
    float ds = length(pos - center) - radius;
    float dp = pos.y;
    float d = min(ds,dp);
    return d;
}

// Rotation matrix around Y axis
mat3 rotateY(float theta) {
    float c = cos(theta);
    float s = sin(theta);
    return mat3(
        vec3(c, 0, -s),
        vec3(0, 1, 0),
        vec3(s, 0, c)
    );
}

// Rotation matrix around X axis
mat3 rotateX(float theta) {
    float c = cos(theta);
    float s = sin(theta);
    return mat3(
        vec3(1, 0, 0),
        vec3(0, c, -s),
        vec3(0, s, c)
    );
}

// Rotation matrix around Z axis
mat3 rotateZ(float theta) {
    float c = cos(theta);
    float s = sin(theta);
    return mat3(
        vec3(c, -s, 0),
        vec3(s, c, 0),
        vec3(0, 0, 1)
    );
}

float map(in vec3 pos)
{
    float d = MAX_DIST;
    
    // Define the center of rotation
    vec3 cubeCenter = vec3(lt_x,lt_y,lt_z);
    
    // Create rotation matrices
    float rotationSpeed = 0.5;
    mat3 rotMatrix = rotateY(u_time * rotationSpeed) * 
                    rotateX(u_time * rotationSpeed * 0.7) * 
                    rotateZ(u_time * rotationSpeed * 0.3);
    
    for(int x = 0; x < GRID_SIZE; x++)
    {
        for(int y = 0; y < GRID_SIZE; y++)
        {
            for(int z = 0; z < GRID_SIZE; z++)
            {
                // Calculate grid position relative to center
                vec3 gridPos = vec3(
                    x - (GRID_SIZE - 1) / 2.0,
                    y - (GRID_SIZE - 1) / 2.0,
                    z - (GRID_SIZE - 1) / 2.0
                ) * SPACING;
                
                // Apply rotation to grid position
                vec3 rotatedPos = rotMatrix * gridPos;
                
                // Offset the final position
                vec3 sphereCenter = rotatedPos + cubeCenter;
                
                float sphereRadius = 0.3;
                float distToSphere = sphereDistance(pos, sphereCenter, sphereRadius);
                d = min(d, distToSphere);
            }
        }
    }
    return d;
}

vec3 calcNormal(in vec3 pos)
{
    vec2 e = vec2(0.0001, 0.0);
    return normalize(vec3(
        map(pos + e.xyy) - map(pos - e.xyy),
        map(pos + e.yxy) - map(pos - e.yxy),
        map(pos + e.yyx) - map(pos - e.yyx)
    ));
}

float ray_march(vec3 ro, vec3 rd)
{
    float t = 0.0;
    for(int i = 0; i < MAX_STEPS; i++)
    {
        vec3 pos = ro + t * rd;
        float h = map(pos);
        t += h;
        if(h < SURFACE_DIST || t > MAX_DIST)
            break;
    }
    return t;
}

// Fresnel-Schlick approximation
float fresnel(float cosTheta, float F0) {
    return F0 + (1.0 - F0) * pow(1.0 - cosTheta, 5.0);
}

vec3 getEnvironmentLight(vec3 dir) {
    float y = 0.5 + 0.5 * dir.y;
    return mix(vec3(0.1, 0.2, 0.3), vec3(0.5, 0.7, 1.0), y);
}

vec3 shade(vec3 pos, vec3 rd, vec3 normal, Material material) 
{
    vec3 sun_dir = normalize(vec3(0.8, 0.4, 0.8));
    vec3 view_dir = -rd;
    
    // Direct lighting
    float sun_diff = clamp(dot(normal, sun_dir), 0.0, 1.0);
    float sky_dif = clamp(0.5 + 0.5 * dot(normal, vec3(0.0, 1.0, 0.0)), 0.0, 1.0);
    
    // Reflection vector
    vec3 reflection_dir = reflect(rd, normal);
    
    // Calculate fresnel
    float F = fresnel(max(dot(normal, view_dir), 0.0), material.fresnel);
    
    // Get reflection color
    vec3 reflection_color = vec3(0.0);
    float reflection_dist = ray_march(pos + normal * SURFACE_DIST * 2.0, reflection_dir);
    if(reflection_dist < MAX_DIST) {
        vec3 reflection_pos = pos + reflection_dir * reflection_dist;
        vec3 reflection_normal = calcNormal(reflection_pos);
        float reflection_diff = clamp(dot(reflection_normal, sun_dir), 0.0, 1.0);
        reflection_color = material.albedo * reflection_diff;
    } else {
        reflection_color = getEnvironmentLight(reflection_dir);
    }
    
    // Combine direct lighting and reflections
    vec3 direct_light = material.albedo * (vec3(1.0, 0.7, 0.5) * sun_diff + vec3(0.0, 0.1, 0.25) * sky_dif);
    vec3 final_color = mix(direct_light, reflection_color, F * REFLECTION_INTENSITY);
    
    return final_color;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = (2.0 * fragCoord.xy - u_resolution.xy) / u_resolution.y; 
    vec3 ray_origin = vec3(ro_x, ro_y, ro_z);
    vec3 lookat = vec3(lt_x, lt_y, lt_z);
    vec3 f = normalize(lookat - ray_origin);
    vec3 r = normalize(cross(vec3(0.0, 1.0, 0.0), f));
    vec3 u = normalize(cross(f, r));
    float zoom = zoom_level+sin(u_time);
    vec3 c = ray_origin + f * zoom;
    vec3 i = c + uv.x * r + uv.y * u;
    vec3 ray_dir = normalize(i - ray_origin);
    
    float d = ray_march(ray_origin, ray_dir);
    vec3 col = vec3(0.0);
    
    if(d < MAX_DIST)
    {
        vec3 pos = ray_origin + d * ray_dir;
        vec3 norm = calcNormal(pos);
        
        // Define material properties
        Material material;
        material.albedo = vec3(0.95, 0.64, 0.54);  // Copper-like color
        material.metallic = 0.1;
        material.roughness = 0.1;
        material.fresnel = 0.95;
        
        col = shade(pos, ray_dir, norm, material);
    }
    else {
        col = getEnvironmentLight(ray_dir);
    }
    
    // Basic tone mapping
    col = col / (1.0 + col);
    // col = pow(col, vec3(0.4545));  // gamma correction
    
    fragColor = vec4(col, 1.0);
}
#endif

#if 0
#define MAX_STEPS               100
#define SURFACE_DIST            0.001
#define MAX_DIST                20.0
#define GRID_SIZE               3
#define SPACING                 1.2
#define REFLECTION_STEPS        32
#define REFLECTION_INTENSITY    0.4
#define CHROMATIC_STRENGTH      0.03  // Strength of the chromatic aberration

// Material properties
struct Material {
    vec3 albedo;
    float metallic;
    float roughness;
    float fresnel;
};

float sphereDistance(vec3 pos, vec3 center, float radius)
{
    float ds = length(pos - center) - radius;
    float dp = pos.y;
    float d = min(ds,dp);
    return d;
}

float map(in vec3 pos)
{
    float d = MAX_DIST;
    for(int x = 0; x < GRID_SIZE; x++)
    {
        for(int y = 0; y < GRID_SIZE; y++)
        {
            for(int z = 0; z < GRID_SIZE; z++)
            {
                vec3 sphereCenter = vec3(x+0, y+2, z+3) * SPACING + vec3(-1.0) * SPACING * (GRID_SIZE - 1) / 2.0;
                float sphereRadius = 0.3;
                float distToSphere = sphereDistance(pos, sphereCenter, sphereRadius);
                d = min(d, distToSphere);
            }
        }
    }
    return d;
}

vec3 calcNormal(in vec3 pos)
{
    vec2 e = vec2(0.0001, 0.0);
    return normalize(vec3(
        map(pos + e.xyy) - map(pos - e.xyy),
        map(pos + e.yxy) - map(pos - e.yxy),
        map(pos + e.yyx) - map(pos - e.yyx)
    ));
}

float ray_march(vec3 ro, vec3 rd)
{
    float t = 0.0;
    for(int i = 0; i < MAX_STEPS; i++)
    {
        vec3 pos = ro + t * rd;
        float h = map(pos);
        t += h;
        if(h < SURFACE_DIST || t > MAX_DIST)
            break;
    }
    return t;
}

float fresnel(float cosTheta, float F0) {
    return F0 + (1.0 - F0) * pow(1.0 - cosTheta, 5.0);
}

vec3 getEnvironmentLight(vec3 dir) {
    float y = 0.5 + 0.5 * dir.y;
    return mix(vec3(0.1, 0.2, 0.3), vec3(0.5, 0.7, 1.0), y);
}

// Function to get reflection color with chromatic aberration
vec3 getReflectionColor(vec3 pos, vec3 normal, vec3 reflection_dir, Material material) {
    vec3 reflection_color = vec3(0.0);
    
    // Offset directions for RGB channels
    vec3 offsets = vec3(-CHROMATIC_STRENGTH, 0.0, CHROMATIC_STRENGTH);
    
    // Calculate reflection for each color channel
    for(int i = 0; i < 3; i++) {
        vec3 offset_dir = normalize(reflection_dir + normal * offsets[i]);
        float reflection_dist = ray_march(pos + normal * SURFACE_DIST * 2.0, offset_dir);
        
        if(reflection_dist < MAX_DIST) {
            vec3 reflection_pos = pos + offset_dir * reflection_dist;
            vec3 reflection_normal = calcNormal(reflection_pos);
            vec3 sun_dir = normalize(vec3(0.8, 0.4, 0.8));
            float reflection_diff = clamp(dot(reflection_normal, sun_dir), 0.0, 1.0);
            reflection_color[i] = (material.albedo * reflection_diff)[i];
        } else {
            reflection_color[i] = getEnvironmentLight(offset_dir)[i];
        }
    }
    
    return reflection_color;
}

vec3 shade(vec3 pos, vec3 rd, vec3 normal, Material material) {
    vec3 sun_dir = normalize(vec3(0.8, 0.4, 0.8));
    vec3 view_dir = -rd;
    
    // Direct lighting
    float sun_diff = clamp(dot(normal, sun_dir), 0.0, 1.0);
    float sky_dif = clamp(0.5 + 0.5 * dot(normal, vec3(0.0, 1.0, 0.0)), 0.0, 1.0);
    
    // Reflection vector
    vec3 reflection_dir = reflect(rd, normal);
    
    // Calculate fresnel
    float F = fresnel(max(dot(normal, view_dir), 0.0), material.fresnel);
    
    // Get reflection color with chromatic aberration
    vec3 reflection_color = getReflectionColor(pos, normal, reflection_dir, material);
    
    // Add subtle color shift to direct lighting based on normal
    vec3 direct_light = material.albedo * (
        vec3(1.0, 0.7, 0.5) * sun_diff + 
        vec3(0.0, 0.1, 0.25) * sky_dif +
        vec3(0.02, -0.01, -0.01) * dot(normal, view_dir)  // Subtle color shift
    );
    
    // Combine direct lighting and reflections
    vec3 final_color = mix(direct_light, reflection_color, F * REFLECTION_INTENSITY);
    
    // Add subtle edge glow
    float edge = 1.0 - abs(dot(normal, view_dir));
    final_color += vec3(0.1, 0.2, 0.3) * pow(edge, 3.0) * material.metallic;
    
    return final_color;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = (2.0 * fragCoord.xy - u_resolution.xy) / u_resolution.y; 
    vec3 ray_origin = vec3(ro_x, ro_y, ro_z);
    vec3 lookat = vec3(lt_x, lt_y, lt_z);
    vec3 f = normalize(lookat - ray_origin);
    vec3 r = normalize(cross(vec3(0.0, 1.0, 0.0), f));
    vec3 u = normalize(cross(f, r));
    float zoom = zoom_level;
    vec3 c = ray_origin + f * zoom;
    vec3 i = c + uv.x * r + uv.y * u;
    vec3 ray_dir = normalize(i - ray_origin);
    
    float d = ray_march(ray_origin, ray_dir);
    vec3 col = vec3(0.0);
    
    if(d < MAX_DIST)
    {
        vec3 pos = ray_origin + d * ray_dir;
        vec3 norm = calcNormal(pos);
        
        // Define material properties
        Material material;
        material.albedo = vec3(0.95, 0.64, 0.54);  // Copper-like color
        material.metallic = 0.9;
        material.roughness = 0.1;
        material.fresnel = 0.95;
        
        col = shade(pos, ray_dir, norm, material);
    }
    else {
        col = getEnvironmentLight(ray_dir);
    }
    
    // Enhanced post-processing
    // Subtle color separation at edges
    float vignette = 1.0 - length(uv * 0.5);
    col *= vec3(vignette, vignette * 1.02, vignette * 0.98);
    
    // Tone mapping with slight color grading
    col = col / (1.0 + col);
    col = pow(col, vec3(0.4545));  // gamma correction
    
    // Subtle color adjustment
    col = mix(col, col * vec3(1.02, 1.0, 0.98), 0.5);
    
    fragColor = vec4(col, 1.0);
}
#endif

#if 0

float map(in vec3 pos)
{
    // sphere             rad
    float d = length(pos)-0.3;
    return d;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = (2.0*fragCoord.xy-u_resolution.xy)/u_resolution.y; 
    float d = length(uv)*0.5;

    // Camera
    vec3 ray_origin = vec3(sin(u_time), 0.0, 2.0+cos(u_time));
    vec3 ray_dir    = normalize(vec3(uv,-2.5));

    vec3 c = vec3(0.0);

    float t = 0.0;
    for(int i = 0; i < 100; i++)
    {
        vec3 pos = ray_origin + t*ray_dir;
        float h = map(pos);

        if(h<0.001){
            break;
        }
        t+=h;

        if(t > 20.0){
            break;
        }
    }

    if(t < 20.0){
        vec3 pos = ray_origin + t*ray_dir;
        c = pos.zzz;
    }

    fragColor = vec4(c, 1.0);
} 

#endif


#if 0

float map(in vec3 pos)
{
    // sphere             rad
    float d = length(pos)-0.3;
    return d;
}

vec3 calcNormal(in vec3 pos)
{
    vec2 e = vec2(0.0001,0.0);
    return normalize(vec3(map(pos+e.xyy)-map(pos-e.xyy),
                          map(pos+e.yxy)-map(pos-e.yxy),
                          map(pos+e.yyx)-map(pos-e.yyx)));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{   
    vec2 uv = (2.0*fragCoord.xy-u_resolution.xy)/u_resolution.y; 
    float d = length(uv)*0.5;

    // Camera
    vec3 ray_origin    = vec3(0.0, 0.0, 1.5);
    vec3 ray_dir = normalize(vec3(uv,-1.5));

    vec3 c = vec3(0.0);

    float t = 0.0;
    for(int i = 0; i < 100; i++)
    {
        vec3 pos = ray_origin + t*ray_dir;
        float h = map(pos);

        if(h<0.001){
            break;
        }
        t+=h;

        if(t > 20.0){
            break;
        }
    }

    if(t < 20.0){
        vec3 pos = ray_origin + t*ray_dir;
        vec3 norm = calcNormal(pos);

        vec3 sun_dir = normalize(vec3(0.8,0.4,sin(u_time)));
        float sun_diff = clamp(dot(norm, sun_dir),0.0,1.0);
        float sky_dif = clamp(0.5 + 0.5 * dot(norm,vec3(0.0,1.0,0.0)),0.0,1.0); 
        c = vec3(1.0,0.7,0.5)*sun_diff;
        c += vec3(0.0,0.1,0.25)*sky_dif;
    }


    fragColor = vec4(c, 1.0);
} 
#endif


#if 0
void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{
    vec3 c;
    float l, z = u_time;
    for (int i = 0; i < 3; i++) {
        vec2 uv, p = fragCoord.xy / u_resolution;
        uv = p;
        p -= 0.5;
        p.x *= u_resolution.x / u_resolution.y;
        z += 0.07;
        l = length(p);
        uv += p / l * (sin(z) + 1.) * abs(sin(l * 9. - z - z));
        c[i] = 0.01 / length(mod(uv, 1.0) - 0.5);
    }
    fragColor = vec4(c / l, u_time);
} 
#endif

#if 0
precision highp float;

float gTime = 0.;
const float REPEAT = 5.0;

mat2 rot(float a) {
    float c = cos(a), s = sin(a);
    return mat2(c,s,-s,c);
}

float sdBox( vec3 p, vec3 b )
{
    vec3 q = abs(p) - b;
    return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0);
}

float box(vec3 pos, float scale) {
    pos *= scale;
    float base = sdBox(pos, vec3(.4,.4,.1)) /1.5;
    pos.xy *= 5.;
    pos.y -= 3.5;
    pos.xy *= rot(.75);
    float result = -base;
    return result;
}

float box_set(vec3 pos, float u_time) {
    vec3 pos_origin = pos;
    pos = pos_origin;
    pos .y += sin(gTime * 0.4) * 2.5;
    pos.xy *=   rot(.8);
    float box1 = box(pos,2. - abs(sin(gTime * 0.4)) * 1.5);
    pos = pos_origin;
    pos .y -=sin(gTime * 0.4) * 2.5;
    pos.xy *=   rot(.8);
    float box2 = box(pos,2. - abs(sin(gTime * 0.4)) * 1.5);
    pos = pos_origin;
    pos .x +=sin(gTime * 0.4) * 2.5;
    pos.xy *=   rot(.8);
    float box3 = box(pos,2. - abs(sin(gTime * 0.4)) * 1.5); 
    pos = pos_origin;
    pos .x -=sin(gTime * 0.4) * 2.5;
    pos.xy *=   rot(.8);
    float box4 = box(pos,2. - abs(sin(gTime * 0.4)) * 1.5); 
    pos = pos_origin;
    pos.xy *=   rot(.8);
    float box5 = box(pos,.5) * 6.;  
    pos = pos_origin;
    float box6 = box(pos,.5) * 6.;  
    float result = max(max(max(max(max(box1,box2),box3),box4),box5),box6);
    return result;
}

float map(vec3 pos, float u_time) {
    vec3 pos_origin = pos;
    float box_set1 = box_set(pos, u_time);

    return box_set1;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 p = (fragCoord.xy * 2. - u_resolution.xy) / min(u_resolution.x, u_resolution.y);
    vec3 ro = vec3(0., -0.2 ,u_time * 4.);
    vec3 ray = normalize(vec3(p, 1.5));
    ray.xy = ray.xy * rot(sin(u_time * .03) * 5.);
    ray.yz = ray.yz * rot(sin(u_time * .05) * .2);
    float t = 0.1;
    vec3 col = vec3(0.);
    float ac = 0.0;


    for (int i = 0; i < 99; i++){
        vec3 pos = ro + ray * t;
        pos = mod(pos-2., 4.) -2.;
        gTime = u_time -float(i) * 0.01;
        
        float d = map(pos, u_time);

        d = max(abs(d), 0.01);
        ac += exp(-d*23.);

        t += d* 0.55;
    }

    col = vec3(ac * 0.02);

    col +=vec3(0.,0.2 * abs(sin(u_time)),0.5 + sin(u_time) * 0.2);


    fragColor = vec4(col ,1.0 - t * (0.02 + 0.02 * sin (u_time)));
}

#endif

#if 0
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 r = u_resolution.xy;
    float t = u_time;
    vec2 p = (fragCoord.xy - r * 0.5) / r.y;

    p = vec2(atan(p.y, p.x) / 0.1, log(dot(p, p)) / 0.2 + t);
    
    vec4 o;

    for(float i = 0.0; i < 8.0; i++) 
    {
        o = sin(p.xyxy * 0.2 + vec4(0, 2, 3, 3)) * 0.5 + 0.5;
        p += 0.9 * cos(p.yx + tan(i * vec2(7, 9)));
    }
    
    fragColor = o;
}
#endif

#if 0

// See here for more information on smooth iteration count:
//
// https://iquilezles.org/articles/msetsmooth


// increase this if you have a very fast GPU
#define AA 2

float mandelbrot( in vec2 c )
{
    #if 1
    {
        float c2 = dot(c, c);
        // skip computation inside M1 - https://iquilezles.org/articles/mset1bulb
        if( 256.0*c2*c2 - 96.0*c2 + 32.0*c.x - 3.0 < 0.0 ) return 0.0;
        // skip computation inside M2 - https://iquilezles.org/articles/mset2bulb
        if( 16.0*(c2+2.0*c.x+1.0) - 1.0 < 0.0 ) return 0.0;
    }
    #endif


    const float B = 256.0;
    float l = 0.0;
    vec2 z  = vec2(0.0);
    for( int i=0; i<512; i++ )
    {
        z = vec2( z.x*z.x - z.y*z.y, 2.0*z.x*z.y ) + c;
        if( dot(z,z)>(B*B) ) break;
        l += 1.0;
    }

    if( l>511.0 ) return 0.0;
    
    // ------------------------------------------------------
    // smooth interation count
    //float sl = l - log(log(length(z))/log(B))/log(2.0);

    // equivalent optimized smooth interation count
    float sl = l - log2(log2(dot(z,z))) + 4.0;

    float al = smoothstep( -0.1, 0.0, sin(0.5*6.2831*u_time ) );
    l = mix( l, sl, al );

    return l;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec3 col = vec3(0.0);
    
#if AA>1
    for( int m=0; m<AA; m++ )
    for( int n=0; n<AA; n++ )
    {
        vec2 p = (-u_resolution.xy + 2.0*(fragCoord.xy+vec2(float(m),float(n))/float(AA)))/u_resolution.y;
        float w = float(AA*m+n);
        float time = u_time + 0.5*(1.0/24.0)*w/float(AA*AA);
#else    
        vec2 p = (-u_resolution.xy + 2.0*fragCoord.xy)/u_resolution.y;
        float time = u_time;
#endif
    
        float zoo = 0.62 + 0.38*cos(.07*time);
        float coa = cos( 0.15*(1.0-zoo)*time );
        float sia = sin( 0.15*(1.0-zoo)*time );
        zoo = pow( zoo,8.0);
        vec2 xy = vec2( p.x*coa-p.y*sia, p.x*sia+p.y*coa);
        vec2 c = vec2(-.745,.186) + xy*zoo;

        float l = mandelbrot(c);

        col += 0.5 + 0.5*cos( 3.0 + l*0.15 + vec3(0.0,0.6,1.0));
#if AA>1
    }
    col /= float(AA*AA);
#endif

    fragColor = vec4( col, 1.0 );
}

#endif

#if 0

/*
    "Circle Anti-aliasing" by @XorDev
    
    Often times shaders introduce hard edges (aliasing) unintentionally.
    Aliasing is fine if you're going for pixelated style, but aliasing
    rarely occurs in nature and it often makes shaders look fake.
    
    The simplest example I could think of is with a circle. You could
    draw a circle by check if a pixel is within the radius of the circle.
    Like: fragColor = vec4(dist < rad);
    It does however introduce hard pixel edges.
    Alternatively, if you know (or can approximate) how close a pixel is
    to the edge, you can do a little sub-pixel gradient along the edge.
    This is easy to do with distance-fields because they have a
    consistent scale, but it can also be approximated when needed.
    
    
    More on this in the upcoming tutorial:
    https://mini.gmshaders.com
*/

//Number of pixel rows
#define ROWS 100.0
//Edge softness (0.5 spreads across 2 pixels)
#define SOFT 0.5

void mainImage(out vec4 fragColor, vec2 fragCoord)
{
    //Center the fragment coordinates
    vec2 center = fragCoord - 0.5*u_resolution.xy;
    //Screen height for scaling
    float height = u_resolution.y;
    //Set texel scale
    float texel = 1.0 / zoom_level;
    //Set the displayed pixel scale
    float scale = height * texel;
    
    //Get centered pixel coordinates
    vec2 pixel = floor(center/scale)+0.5;

    //Circle radius (0.5 spans the full screen height)
    float radius = 0.35+0.1*cos(u_time);
    //Get the distance to the circle in texel units
    float dist = radius - texel * length(pixel);
    
    //Move divider with mouse
    float mouse = (u_resolution.x*0.5-u_mouse.x)*float(u_mouse.z>0.0);
    //Display anti-aliasing on the right
    bool AA = pixel.x+mouse*texel>0.0;
    //Circle with hard clipping
    float clip = float(dist>0.0);
    //Circle with smooth gradient edges
    float grad = clamp(dist / texel + 0.5, 0.0, 1.0);

    //Toggle anti-aliasing across divider
    fragColor = vec4(AA ? grad : clip);
    
    //Red circle alpha:
    //Ring distance in pixel units
    float ring = abs(radius*height - length(center));
    //Set thickness based on pixel scale
    float circle = clamp(SOFT*(0.08*scale - ring) + 0.5, 0.0, 1.0);
    
    //Green pixel alpha:
    //Distance to nearest dot cell
    float dots = distance(pixel*scale, center);
    //Set thickness based on pixel scale
    float pixels = clamp(SOFT*(0.12*scale - dots) + 0.5, 0.0, 1.0);
    //Only draw pixels within radius
    pixels *= float(dist > -0.5*texel*float(AA));
    
    //Blue divider alpha:
    float divider = clamp(SOFT * (2.0 - abs(center.x+mouse))+0.5, 0.0, 1.0);
    
    //Blend elements together
    fragColor += (vec4(1,0,0,1)-fragColor) * circle;
    fragColor += (vec4(0,1,0,1)-fragColor) * pixels;
    fragColor += (vec4(0,0,1,1)-fragColor) * divider;
}
#endif

#if 0
#define PI 3.141592653589793

// 2D Rotation Matrix
mat2 rotate2D(float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return mat2(c, -s, s, c);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{
    vec2 p = (fragCoord.xy - u_resolution.xy * 0.5) / u_resolution.y;
    vec4 o = vec4(0.0);

    for (float i = 1.0, a; i < 1e2; i *= 1.05) {
        a = mod(cos(cos(i * 3e3) * 3e3) * 3e3 + u_time, 10.0);
        o += (5.0 - abs(a - 5.0)) * (cos(i + p.x * 5.0 + vec4(0, 2, 1, 0)) + 1.0) / 1e3 / max(a = length(cos((p * sqrt(i) + i * i) * rotate2D(i) + a * sqrt(i) * 0.01)) - 0.05, 0.01 - a * 0.1);
    }

    o = tanh(pow(o.rgga * o.rgra, vec4(1, 1, 2, 1)));
    o += (1.0 - o) * (cos(p.y * PI + vec4(0, 1, 3, 0)) * 0.1);

    fragColor = o;
}
#endif

#if 0

#define PI 3.141592653589793
#define PI2 6.283185307179586

// 2D Simplex Noise by Ian McEwan (Ashima Arts)
vec3 permute(vec3 x) { return mod(((x*34.0)+1.0)*x, 289.0); }

float snoise(vec2 v) {
    const vec4 C = vec4(0.211324865405187, 0.366025403784439,
                        -0.577350269189626, 0.024390243902439);
    vec2 i = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);
    vec2 i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy -= i1;
    i = mod(i, 289.0);
    vec3 p = permute(permute(i.y + vec3(0.0, i1.y, 1.0)) + i.x + vec3(0.0, i1.x, 1.0));
    vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
    m = m * m;
    m = m * m;
    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;
    m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
    vec3 g;
    g.x = a0.x * x0.x + h.x * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}

// 2D Rotation Matrix
mat2 rotate2D(float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return mat2(c, -s, s, c);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{
    vec2 p = (fragCoord.xy - u_resolution.xy * 0.5) / u_resolution.y;
    vec2 v = vec2(0.0);

    for (float i = 1.0; i < 1e1; i *= 1.5) {
        v = floor(0.2 + p * 0.5 * rotate2D(floor(i * 9.0) * PI / 4.0) * i + snoise(v) * 3.0);
    }

    vec4 o = cos(dot(p, normalize(cos(v.yx * 9.0))) * 5.0 + u_time * PI2 * 0.1 + snoise(v) * 20.0 + vec4(0, 1.8, 1.3, 3)) * 0.5 + 0.5;
    o *= o * vec4(1, 1, 0.4, 1);

    fragColor = o;
}
#endif

#if 0

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 r = u_resolution.xy;
    vec2 p = (fragCoord.xy * 2.0 - r) / r.y;
    vec2 v;
    vec4 o = vec4(0.0);
    float t = u_time;
    
    for(float i = 1.0; i < 9.0; i++) {
        float a = mod(i + log(length(p))/0.5 - t, 10.0);
        vec2 v = sin(vec2(atan(p.y, p.x) + i, log(length(p)) - 0.2 * a/i + i*i) * i) - 0.5;
        o += (cos(i + vec4(0,1,2,3)) + 1.0) / 
             (1.0 + 0.1 * log(length(p))) * 
             (1.0 - abs(a - 5.0)/5.0) /
             (0.1 + length(max(v, -v * 0.3)));
    }
    
    o = tanh(o * o * vec4(1,1,1,1) / 400.0);
    
    fragColor = o;
}
#endif

#if 0

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 r = u_resolution.xy;
    vec2 p = (fragCoord.xy * 2.0 - r) / r.y;
    vec2 v;
    vec4 o = vec4(0.0);
    float t = u_time;
    
    for(float i = 1.0; i < 9.0; i++) {
        float l = log(length(p));
        float a = mod(i + l/0.3 + t, 10.0);
        v = sin(vec2(atan(p.y, p.x) + i, l - 0.2 * a/i + i*i) * i) - 0.5;
        o += (cos(i + vec4(6,1,2,3)) + 1.0) / 
             (1.0 + 0.1 * l) * 
             (1.0 - abs(a - 5.0)/5.0) /
             (0.1 + length(max(v, -v.yx * 0.4)));
    }
    
    o = tanh(o * o * vec4(2,1,2,1) / 400.0);
    
    fragColor = o;
}
#endif


#if 0

#define PI 3.141592653589793

// 2D Simplex Noise by Ian McEwan (Ashima Arts)
vec3 permute(vec3 x) { return mod(((x*34.0)+1.0)*x, 289.0); }

float snoise(vec2 v) 
{
    const vec4 C = vec4(0.211324865405187, 0.366025403784439,
                        -0.577350269189626, 0.024390243902439);
    vec2 i = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);
    vec2 i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy -= i1;
    i = mod(i, 289.0);
    vec3 p = permute(permute(i.y + vec3(0.0, i1.y, 1.0)) + i.x + vec3(0.0, i1.x, 1.0));
    vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
    m = m * m;
    m = m * m;
    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;
    m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
    vec3 g;
    g.x = a0.x * x0.x + h.x * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}

#define F(V) (0.1/length((p-clamp(p,-b,b))*(V)) + 0.1/length((p-clamp(p,-vec2(0.2,4.),b.yx))*(V)))

void mainImage(out vec4 fragColor, in vec2 fragCoord) 
{
    vec2 b = vec2(2., 0.2);
    vec2 p = (fragCoord.xy - 0.5 * u_resolution.xy) / (u_resolution.y * 0.1) + b * 0.5 - 1.0;
    
    vec2 c = pow(b + cos(u_time * PI - abs(p.yx) / (0.1 + 0.05 * length(p))) * b * 0.2, sign(p) * 0.5);
    
    vec3 o;
    o.r = F(c);
    o.g = F(c / c);
    o.b = F(1.0 / c);
    
    o = tanh(o * exp(snoise(p) * 0.1));
    
    fragColor = vec4(o, 1.0);
}
#endif

#if 0
// evening sketch by @mmalex
// having a go at re-creating @vector_gl's lovely gif https://twitter.com/Vector_GL/status/612337298064150529
// now with triangle wave!

#define moblur 10
#define harmonic 10
#define triangle 1 // comment this line out for only square

vec3 circle(vec2 uv, float rr, float cc, float ss) {
    
    uv*=mat2(cc,ss,-ss,cc);
    if (rr<0.) uv.y=-uv.y;
    rr=abs(rr);
    float r = length(uv)-rr;
    float pix=fwidth(r);
    float c = smoothstep(0.,pix,abs(r));
    float l = smoothstep(0.,pix,abs(uv.x)+step(uv.y,0.)+step(rr,uv.y));
    return vec3(c,c*l,c*l);
}
vec3 ima(vec2 uv, float th0) {
    vec3 col=vec3(1.0);
    vec2 uv0=uv;
    th0-=max(0.,uv0.x-1.5)*2.;
    th0-=max(0.,uv0.y-1.5)*2.;
#ifndef triangle
float lerpy = 1.;
#else
float lerpy =smoothstep(-0.6,0.2,cos(th0*0.1));
#endif

    for (int i=1;i<harmonic;i+=2) {
        float th=th0*float(i);
        float fl=mod(float(i),4.)-2.;// used to be repeated assignment fl=-fl, but compiler bugs. :(
        float cc=cos(th)*fl,ss=sin(th);
        float trir=-fl/float(i*i);
        float sqrr=1./float(i);
        float rr=mix(trir,sqrr,lerpy);
        col = min(col, circle(uv,rr,cc,ss));
        uv.x+=rr*ss;
        uv.y-=rr*cc;
    }
    float pix=fwidth(uv0.x);
    if (uv.y>0. && fract(uv0.y*10.)<0.5) col.yz=min(col.yz,smoothstep(0.,pix,abs(uv.x)));
    if (uv.x>0. && fract(uv0.x*10.)<0.5) col.yz=min(col.yz,smoothstep(0.,pix,abs(uv.y)));
    if (uv0.x>=1.5) col.xy=vec2(smoothstep(0.,fwidth(uv.y),abs(uv.y)));    
    if (uv0.y>=1.5) col.xy=vec2(smoothstep(0.,fwidth(uv.x),abs(uv.x)));    
    return col;
}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / u_resolution.yy;
    uv.y=1.-uv.y;
    uv*=5.;
    uv-=1.5;
    float th0=u_time*2.;
    float dt=2./60./float(moblur);
    vec3 col=vec3(0.);
    for (int mb=0;mb<moblur;++mb) {
        col+=ima(uv,th0);
        th0+=dt;
    }
    col=pow(col*(1./float(moblur)),vec3(1./2.2));
    fragColor=vec4(col,1.);
}
#endif

#if 0
void mainImage(out vec4 O, vec2 I)
{
    //Resolution for scaling
    vec3 r = vec3(u_resolution,1),
    //Camera Position (approximately vec3(0,0,2.5))
    p = 2.5/r,
    //Absolute position
    a;
    
    //Iterate 40 times and set color
    for(;r.z++<4e1; O = 2.+vec4(p.x,-p.x,a))
        //Raymarch with box and sphere SDF
        p += vec3(I+I-r.xy,-r)/r.x * min(1.-max(a=abs(p),max(a.y,-p.z)).x, length(p+.5)-.5);
        
    //Fun mode:
    O = 2.+p.x*sign(sin(u_time+vec4(0,2,4,0)));
    //Top light
    O = .01/length(max(a.xz/.2-p.y,0.))+
    //Bounce lighting
    .8/O+
    //Wall coloring
    3e1* min(3.-O, .01);
    //AO and shading
    O /= dot(p,p)+.4/dot(p+.5,p+.8);
}
#endif

void main() 
{
    vec2 fragCoord = TexCoord * u_resolution;
    mainImage(FragColor, fragCoord);
}
