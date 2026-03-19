using CairoMakie

res = 15

function s(x)
  return abs(round(x/2) - x/2) * 2
end

function blacmange(x)
  return sum((s(2^n * x) / 2^n) for n in 0:res)
end

function weierstrass(x)
  return sum((cos(5^n * pi * x) / 2^n) for n in 0:res)
end

fig = Figure()
#ax = Axis(fig[1, 1], limits=(0.2, 0.6, 0.2, 1.35))
ax = Axis(fig[1, 1])
hidespines!(ax, :t, :r)

if ARGS[1] == "blacmange"
  lines!(ax, 0..2, blacmange; color = :darkblue)
else
  lines!(ax, -1..1, weierstrass; color = :darkblue)
end

save(ARGS[2], fig)
