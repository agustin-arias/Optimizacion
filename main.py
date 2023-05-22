import numpy as np
import pandas as pd

df = pd.read_csv("./data/datos1_tp.csv")

print(df)

Y = df["Y"].to_numpy()
n = np.shape(Y)[0]
print(f"n: {n}")

X = df[df.columns.drop("Y")].to_numpy()
p = np.shape(X)[1]
print(f"p: {p}")

b = X.transpose() @ Y
print(f"b: {b}")

c = Y.transpose() @ Y
print(f"c: {c}")


# Estimador de minimos cuadrados
beta_inicial = np.ones(p)
# print(X @ beta_inicial)
G = 2 * X.transpose() @ X
print(G)
# beta = gradient_descent(G, beta_inicial)
# println("beta: $beta")
