# Mixed-gamma certificate audit

This directory independently regenerates the six polynomial systems used in
the full mixed-gamma `(1,-1,-1)` scaffold computation.  It does not import the
originating SymPy programs and does not use SymPy differentiation or
substitution to construct the raw determinant.  Instead it uses explicit
coefficient-map arithmetic.

For each case, CI performs four checks:

1. regenerate the committed Singular input byte-for-byte with Python 3.12 and
   hash-pinned SymPy 1.14.0;
2. compute `G = liftstd(I,T)` over `QQ` with Singular 4.3.2p10 and check that
   `G = [1]`;
3. check the exact polynomial identity `matrix(G) = matrix(I) * T`.
4. parse the printed first column of `T` with SymPy and independently check
   `sum(T[i,1] * I[i]) = 1` over `QQ`.

The matrix `T`, Singular session dump, generator log, package inventory, and
SHA-256 inventory are retained as public workflow artifacts.  The first column
of `T` is an explicit Nullstellensatz witness for `1` in the input ideal.

The six normal-form cases are:

- `l`: line;
- `q_t`: t-axis quadratic family, with its parameter symbolic;
- `p`: parabola;
- `h_m`: principal hyperbola family, with `m` symbolic;
- `h_v`: one-linear-term hyperbola;
- `h_0`: pure hyperbola.

This certificate layer verifies the case computations.  The geometric GL2
normal-form classification and the theorem connecting these cases to the full
scaffold are separate proof obligations, intended for Lean formalization.
