using GLMakie
using Colors
using GeometryBasics

min = 0
max = 10

function lighting(diff)
  lighter = 0.7 + 0.6 * sqrt(diff^2 / (1 + diff^2))
  return RGB(0.6 * lighter, 0.68 * lighter, 0.75 * lighter)
end

function f(x)
  return (x-2)*(x-4)*(x-7) / 16 + 5
end

function Df(x)
  return (3x-8)*(x-6) / 16
end

fig = Figure(size=(1600, 800))
ax1 = Axis3(fig[1, 2], aspect=:data, azimuth=-0.3*pi, limits=(min, max+1, min, max+1, 0, 11))
ax2 = Axis3(fig[1, 1], aspect=:data, azimuth=-0.3*pi, limits=(min, max+1, min, max+1, 0, 11))
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

for i = 0:slices
  t = min + (X - min) * i / slices
  ft = f(t)
  Dft = Df(t)
  append!(points, [(t, t, ft),
                   (t, X, ft),
                   (t, t, .0),
                   (t, t, ft)])
  append!(colors,[lighting(Dft),
                  lighting(Dft),
                  RGB(0.25, 0.33, 0.4),
                  RGB(0.25, 0.33, 0.4)])
  append!(slicePoints, [(t, X, ft),
                        (t, X, .0)])
  if i != slices
    append!(faces, [(4*i+1, 4*i+2, 4*i+6),
                    (4*i+1, 4*i+5, 4*i+6),
                    (4*i+4, 4*i+3, 4*i+7),
                    (4*i+4, 4*i+8, 4*i+7)])
    append!(sliceFaces, [(2*i+2, 2*i+1, 2*i+3),
                         (2*i+2, 2*i+4, 2*i+3)])
  end
end
if prevmesh1 != 0
  delete!(ax1, prevmesh1)
end
if prevmesh2 != 0
  delete!(ax2, prevmesh2)
end
global prevmesh1 = mesh!(ax1, points, faces, color=colors, shading=false)
global prevmesh2 = mesh!(ax2, slicePoints, sliceFaces, color=RGB(0.6,0,0), shading=false)
end

#mesh3d(X, Y, Z; connections = (con1, con2, con3), title="2nd integration", xlabel="x", ylabel="y", zlabel="f(x)", legend = :none)
#save(ARGS[1], fig)
