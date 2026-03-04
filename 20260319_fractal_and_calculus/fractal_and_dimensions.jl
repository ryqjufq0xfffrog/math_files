using LinearAlgebra
using Plots

# initiator shape

## Koch curve (0, 0) -> (1/3, 0), (1/3, 0) -> (1/2, 1/(2\sqrt(3))) ...
#shape = [0; 0;; 1/3; 0;;; 1/3; 0;; 0.5; 0.5/sqrt(3) ;;; 0.5; 0.5/sqrt(3);; 2/3; 0 ;;; 2/3; 0;; 1;0]

## Knopp curve (one of Peano curves)
#shape = [0; 0;; 0.5; 0;;; 0.5; 0;; 0.5; 0.5;;; 0.5; 0.5;; 0.5; 0;;; 0.5; 0;; 1; 0]

## Star shape
phi = (1 + sqrt(5)) / 2
shape = [0; 0;; 1/phi^2; 0;;; 1/phi^2; 0;; 0.5; 0.5/phi ;;; 0.5; 0.5/phi;; 1-1/phi^2; 0 ;;; 1-1/phi^2; 0;; 1;0]

## Minkowski sausage
shape = [0; 0;; 0.25; 0;;; 0.25; 0;; 0.25; 0.25;;; 0.25; 0.25;; 0.5; 0.25;;; 0.5; 0.25;; 0.5; 0;;; 0.5; 0;; 0.5; -0.25;;; 0.5; -0.25;; 0.75; -0.25;;; 0.75; -0.25;; 0.75; 0;;; 0.75; 0;; 1; 0]

function nextIter(lines, shape)
  newLines = Array{Float64, 3}(undef, 2, 2, size(lines, 3) * size(shape, 3))
  count = 1
  # each line converted
  for line in axes(lines, 3)
    # iterate through "shape"
    for segm in axes(shape, 3)
      lvector = lines[:, 2, line] - lines[:, 1, line];
      newLines[1, 1, count] = lines[1, 1, line] + lvector[1] * shape[1, 1, segm] - lvector[2] * shape[2, 1, segm]
      newLines[2, 1, count] = lines[2, 1, line] + lvector[1] * shape[2, 1, segm] + lvector[2] * shape[1, 1, segm]
      newLines[1, 2, count] = lines[1, 1, line] + lvector[1] * shape[1, 2, segm] - lvector[2] * shape[2, 2, segm]
      newLines[2, 2, count] = lines[2, 1, line] + lvector[1] * shape[2, 2, segm] + lvector[2] * shape[1, 2, segm]
      count += 1
    end
  end
  return newLines
end

function calcDimension(shape)
  lengths = Array{Float64, 1}(undef, size(shape, 3))
  D = 0;
  for segm in axes(shape, 3)
    svector = shape[:, 2, segm] - shape[:, 1, segm];
    lengths[segm] = norm(svector, 2)
  end
  for i in 1:25
    acm = sum(lengths .^ D) - 1
    derivat = sum(map(x -> log(x) * x ^ D, lengths))
    D -= acm / derivat
  end
  return D
end

function plotLines(p, lines)
  for line in axes(lines, 3)
    plot!(p, lines[1, :, line], lines[2, :, line],
       linecolor=:black)
  end
end

dimension = calcDimension(shape)

# Render
lines = [0; 0;; 1; 0;;;]
for i in 1:4
  global lines = nextIter(lines, shape)
end
p = plot(xlabel="",
        ylabel="",
        title="Fractal dimension = $dimension",
        ratio=1,
        legend=:none);
plotLines(p, lines)
savefig(ARGS[1])
