using CSV
using DataFrames
using LinearAlgebra
using Plots

function cost(Y, X, beta, alpha)
  err = norm(Y-X*beta) + alpha*norm(beta)
  err^2
end

function gradient(G, beta, b)
  output = G*beta + b
  output
end

function gradient_descent(Y, X, G, beta, alpha, b, MAX_ITERATIONS=100, min_error = 1)
err = 10000
i = 1
while err > min_error && i < MAX_ITERATIONS
  #   println("Iteration $i")
    g_k = gradient(G, beta, b)
  #   println("g_k: $g_k")
    learning_rate = 1*transpose(g_k)* g_k / (transpose(g_k)* (G*g_k))
  #   println("learning_rate: $learning_rate")
    beta = beta - learning_rate * g_k
  #   println("beta: $beta")
    err = cost(Y, X, beta, alpha)
  #   println("cost: $err")
    i += 1
end
beta, i
end


beta_hat = [1,3,5,-2,4,9,-3]


## Datos 1
datos_1 = CSV.read("./data/datos1_tp.csv", DataFrame)
Y_1 = datos_1[:, :Y]
X_1 = Matrix(datos_1[:, Not(:Y)])
b_1 = -2 * transpose(X_1) * Y_1
n_1 = size(Y_1,1)
p_1 = size(X_1,2)

## Datos 2
datos_2 = CSV.read("./data/datos2_tp.csv", DataFrame)
Y_2 = datos_2[:, :Y]
X_2 = Matrix(datos_2[:, Not(:Y)])
b_2 = -2 * transpose(X_2) * Y_2
n_2 = size(Y_2,1)
p_2 = size(X_2,2)



# Regresion Ridge
MAX_ITERATIONS = 1000
min_error = 1
alphas = range(1, stop=1000, length=100)
beta_inicial = ones(p_1)


## Datos 1 
errores_1=Any[]
iteraciones_1 = Any[]

for i in 1:length(alphas)
  local alpha = alphas[i]
  local G_1 = 2 * transpose(X_1) * X_1 + 2*alpha*I
  local beta, iteraciones_alpha = gradient_descent(Y_1, X_1, G_1, beta_inicial,alpha, b_1,MAX_ITERATIONS,min_error)
  local error_beta = norm(beta-beta_hat)^2

  append!(errores_1, error_beta)
  append!(iteraciones_1, iteraciones_alpha)
end


## Datos 2
errores_2=Any[]
iteraciones_2 = Any[]

for i in 1:length(alphas)
  local alpha = alphas[i]
  local G_2 = 2 * transpose(X_2) * X_2 + 2*alpha*I
  local beta, iteraciones_alpha = gradient_descent(Y_2, X_2, G_2, beta_inicial,alpha, b_2,MAX_ITERATIONS, min_error) 
  local error_beta = norm(beta-beta_hat)^2

  append!(errores_2, error_beta)
  append!(iteraciones_2, iteraciones_alpha)
end


plot_errores = plot(
  alphas, 
  [errores_1, errores_2],
  title="Errores vs alphas",
  label=["Datos 1" "Datos 2"],
  linewidth=3,
  legend= :bottomright
)

xlabel!("alpha")
ylabel!("Error en beta")
savefig(plot_errores, "./plots/regresion_ridge_errores")


plot_iteraciones = plot(
  alphas, 
  [iteraciones_1, iteraciones_2],
  title="Iteraciones vs alphas",
  label=["Datos 1" "Datos 2"],
  linewidth=3,
  legend= :bottomright
)

xlabel!("alpha")
ylabel!("Iteraciones")
savefig(plot_iteraciones, "./plots/regresion_ridge_iteraciones")

