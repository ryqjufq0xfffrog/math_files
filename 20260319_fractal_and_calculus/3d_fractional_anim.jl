using GLMakie
using Colors
using GeometryBasics

min = 0
max = 10

function lighting(s)
  lighter = 0.6 + cos(27*pi*s) * 0.16
  return RGB(0.6 * lighter, 0.68 * lighter, 0.75 * lighter)
end

function f(x)
  return (x-2)*(x-4)*(x-7) / 16 + 5
end

function Df(x)
  return (3x-8)*(x-6) / 16
end

fig = Figure(size=(800, 800))
ax1 = Axis3(fig[1, 1], aspect=:data, azimuth=0.8*pi, limits=(min, max+1, min, max+1, 0, 11), elevation=0.2*pi)
prevmesh1 = 0
prevmesh2 = 0

record(fig, ARGS[1], LinRange(min, max, 100);
       framerate = 30) do X
slices = 40
points = Point3f[]
faces::AbstractArray{TriangleFace{Int64}, 1} = TriangleFace[]
colors::Vector{Colorant} = []

slicePoints = Point3f[]
sliceFaces::AbstractArray{TriangleFace{Int64}, 1} = TriangleFace[]

fractalPoints = [0/27, 1/27, 2/27, 3/27, 6/27, 7/27, 8/27, 9/27, 18/27, 19/27, 20/27, 21/27, 24/27, 25/27, 26/27, 27/27]

for s in fractalPoints
  for i = 0:slices
    pL = length(points)
    t = min + (X - min) * i / slices
    ft = f(t)
    Dft = Df(t)
    append!(points, [(t, X - s*(X - t), ft),
                     (t, X - s*(X - t), .0)])
    append!(colors, [lighting(s),
                     lighting(s)])
    if i != slices
      append!(faces, [(pL+2, pL+1, pL+3),
                      (pL+2, pL+4, pL+3)])
    end
  end
end

if prevmesh1 != 0
  delete!(ax1, prevmesh1)
end
global prevmesh1 = mesh!(ax1, points, faces, color=colors, shading=false)
end

#mesh3d(X, Y, Z; connections = (con1, con2, con3), title="2nd integration", xlabel="x", ylabel="y", zlabel="f(x)", legend = :none)
#save(ARGS[1], fig)
