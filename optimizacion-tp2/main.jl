using CSV
using DataFrames
using LinearAlgebra
using Statistics

datos_1 = CSV.read("./data/iris.csv", DataFrame)

function V(X, b)
  output = norm(X*b)
  output
end


# matriz_diseño = Matrix(datos_1)
X = Matrix(datos_1[:, Not(:Species)])
matriz_construida = 2 * transpose(X) * X
eigen_vectores = eigvecs(matriz_construida)

b_min = 0
val_min = Inf
for b in eachrow(eigen_vectores)
  if norm(b) <= 1 && V(X,b) < val_min
    global val_min = V(X, b)
    global b_min = b
  end
end
b_1 = b_min
println("b1: ", b_1)
println("norm b1: ", norm(b_1))