#!/usr/bin/env python3
"""
jerk_regress.py

Status: empirical (an exact finite check), not a proof. The general statement
is proved in CrookedPlatonism/Mathlib/OrdersExclusive.lean.

Scope: for the monomial trajectories x_n(t) = t^n / n!, tabulate which orders k
satisfy the self-inversion axiom A_k:  x^(k)(t) != 0 and x^(k)(t) = 1 / x^(k)(t)
for all t. Polynomials are handled exactly with rational coefficients, so the
table involves no floating point and no tolerances.

Reading the table: x_n has n-th derivative identically 1, so A_n holds. Every
other order fails, either because the derivative is nonconstant (k < n) or
because it is identically zero (k > n). The pattern is the same for every n, so
the axiom does not prefer any order. Nothing here selects order 3 over order 6.

Run:  python3 simulations/jerk_regress.py
"""
from fractions import Fraction
from math import factorial

MAX_ORDER = 8


def monomial(n):
    """x_n(t) = t^n / n!  as {exponent: coefficient}."""
    return {n: Fraction(1, factorial(n))}


def derivative(poly):
    return {e - 1: c * e for e, c in poly.items() if e > 0 and c * e != 0}


def nth_derivative(poly, k):
    for _ in range(k):
        poly = derivative(poly)
    return poly


def satisfies_A(poly):
    """A: the function is nowhere zero and equals its reciprocal everywhere.
    For a polynomial this holds exactly when it is a nonzero constant c with
    c * c == 1."""
    if not poly:
        return False                      # identically zero violates c != 0
    if set(poly) != {0}:
        return False                      # nonconstant polynomials vanish or vary
    c = poly[0]
    return c != 0 and c * c == 1


def main():
    orders = range(1, MAX_ORDER + 1)
    print("x_n(t) = t^n / n!;  entry is 'A' where axiom A_k holds for x_n, '.' where it fails")
    print()
    print("      k = " + " ".join(f"{k:>2}" for k in orders))
    for n in orders:
        x = monomial(n)
        row = ["A" if satisfies_A(nth_derivative(x, k)) else "." for k in orders]
        print(f"x_{n}      " + " ".join(f"{r:>2}" for r in row))
    print()
    ok = all(
        satisfies_A(nth_derivative(monomial(n), k)) == (n == k)
        for n in orders for k in orders
    )
    print("A_k holds for x_n exactly when k == n:", ok)
    print("Pairs of orders (m, n), m != n, jointly satisfied by any x_p in this family:",
          sum(
              1
              for p in orders for m in orders for n in orders
              if m < n
              and satisfies_A(nth_derivative(monomial(p), m))
              and satisfies_A(nth_derivative(monomial(p), n))
          ))


if __name__ == "__main__":
    main()
