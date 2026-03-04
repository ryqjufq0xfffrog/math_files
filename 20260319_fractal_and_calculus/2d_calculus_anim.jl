using GLMakie
using Colors
using GeometryBasics

min = 0
max = 10

function f(x)
  return (x-2)*(x-4)*(x-7) / 16 + 5
end

fig = Figure(size=(1600, 800))
ax1 = Axis(fig[1, 2], limits=(min, max+1, 0, 11))
ax2 = Axis(fig[1, 1], limits=(min, max+1, 0, 11))

xs = LinRange(min, max, 30)
ys = f.(xs)
lines!(ax2, xs, ys, color=RGB(0.2, 0.0, 0.7))

prevband = 0
prevline = 0

record(fig, ARGS[1], LinRange(min, max, 100);
       framerate = 30) do X
ts = LinRange(min, X, 30)
ys_high = f.(ts)
ys_low = zeros(30)
if prevband != 0
  delete!(ax1, prevband)
end
if prevline != 0
  delete!(ax2, prevline)
end
global prevband = band!(ax1, ts, ys_low, ys_high, color=RGB(0.7, 0.2, 0.0))
global prevline = lines!(ax2, [X, X], [0, f(X)], color=RGB(0.7, 0.2, 0.0), linewidth=2.0, linecap=:round)
end

#mesh3d(X, Y, Z; connections = (con1, con2, con3), title="2nd integration", xlabel="x", ylabel="y", zlabel="f(x)", legend = :none)
#save(ARGS[1], fig)
