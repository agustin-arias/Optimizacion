using CSV
using DataFrames
using LinearAlgebra

function cost(Y, X, beta)
    err = norm(Y-X*beta)
    err^2
end

function gradient(G, beta, b)
    output = G*beta + b
    output
end

function gradient_descent(Y, X, G, beta, b, MAX_ITERATIONS=100)
  err = 10000
  i = 1
  while err > 0.5 && i < MAX_ITERATIONS
    #   println("Iteration $i")
      g_k = gradient(G, beta, b)
    #   println("g_k: $g_k")
      learning_rate = 1*transpose(g_k)* g_k / (transpose(g_k)* (G*g_k))
    #   println("learning_rate: $learning_rate")
      beta = beta - learning_rate * g_k
    #   println("beta: $beta")
      err = cost(Y, X, beta)
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



# Estimador de minimos cuadrados
## Datos 1 
beta_inicial = ones(p_1)
G_1 = 2 * transpose(X_1) * X_1
beta, iteraciones = gradient_descent(Y_1, X_1, G_1, beta_inicial, b_1)  
error_beta = norm(beta-beta_hat)^2

# Chequeo de numero de condicion
numero_de_condicion_1 = cond(G_1)
println("Numero de condicion para la matriz 1: $numero_de_condicion_1")
println("beta para Estimador de minimos cuadrados. Datos 1: $beta")
println("iteraciones: $iteraciones")
println("error_beta: $error_beta")


println("\n\n\n")

## Datos 2
beta_inicial = ones(p_2)
G_2 = 2 * transpose(X_2) * X_2
beta, iteraciones = gradient_descent(Y_2, X_2, G_2, beta_inicial, b_2)  
error_beta = norm(beta-beta_hat)^2

# Chequeo de numero de condicion
numero_de_condicion_2 = cond(G_2)

println("Numero de condicion para la matriz 2: $numero_de_condicion_2")
println("beta para Estimador de minimos cuadrados. Datos 2: $beta")
println("iteraciones: $iteraciones")
println("error_beta: $error_beta")



