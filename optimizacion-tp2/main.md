# Reduccion de dimesion

## Analisis de componentes principales

## Ejercicio 1

Sean:

$$
X_m = (x_m^{(1)}, \ldots ,x_m^{(n)}) \\
X = (x^{(1)} | \ldots |  x^{(n)})^T = (X_1^T | \ldots | X_p^T)
$$

Tenemos:

$$
\nabla V(b) = \bigg( \frac{\delta V}{\delta b_j} \bigg)_{j=1}^p
$$

Ahora

$$
  \frac{\delta V}{\delta b_j}
    = 2 \sum_{i=1}^n \bigg[ \sum_{k=1}^p x_k^{(i)} b_k \bigg] x_j^{(i)}
    = 2 \sum_{i=1}^n \sum_{k=1}^p x_k^{(i)} x_j^{(i)} b_k
$$

Ahora, sabemos que:

$$
X_k X_j^T
  = \bigg( (X_k)_i \bigg)_{1 \leq i \leq n} \bigg( (X_j)_i \bigg)_{1 \leq i \leq n}^T\\
  = \bigg( x_k^{(i)} \bigg)_{1 \leq i \leq n} \bigg( x_j^{(i)} \bigg)_{1 \leq i \leq n}^T\\
  = \sum_{i=1}^n x_k^{(i)} x_j^{(i)}
$$

y adicionalmente:

$$
b^T X^T
  = \bigg(b_k \bigg)_{1 \leq k \leq p}  (X_1^T| \ldots | X_p^T)^T\\
  = \sum_{k=1}^p b_k X_k
$$

Luego:

$$
  \frac{\delta V}{\delta b_j}
    = 2 \sum_{k=1}^p  b_k \sum_{i=1}^n x_k^{(i)} x_j^{(i)}
    = 2 \sum_{k=1}^p  b_k X_k X_j^T \\
    = 2 \bigg( \sum_{k=1}^p  b_k X_k \bigg) X_j^T
    = 2 b^T X^T X_j^T
$$

Entonces

$$
\nabla V(b)
  = \bigg( \frac{\delta V}{\delta b_j} \bigg)_{j=1}^p \\
  = \bigg( 2 b^T X^T X_j^T \bigg)_{j=1}^p
  = 2 b^T X^T \bigg( X_j^T \bigg)_{j=1}^p \\
  = 2 b^T X^T \bigg( X_j^T \bigg)_{j=1}^p
  = 2 b^T X^T X
$$

$$
\nabla V(b) = 2 X^T  X  b
$$

### Calculo de $b_1$
