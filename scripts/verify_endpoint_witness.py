#!/usr/bin/env python3
"""Verify the printed constant-gamma Singular lift identity over QQ."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path

import sympy as sp

from endpoint_fixed_collision import canonical_digest, fixed_collision_system


def parse_certificate(log_path: Path, variables: list[sp.Symbol], row_count: int) -> list[sp.Expr]:
    lines = log_path.read_text(encoding="utf-8").splitlines()
    cursor = lines.index("CERTIFICATE_MATRIX") + 1
    local_dict = {str(variable): variable for variable in variables}
    rows = []
    for index in range(1, row_count + 1):
        assert lines[cursor] == f"ROW {index}", (index, lines[cursor])
        rows.append(sp.sympify(lines[cursor + 1].replace("^", "**"), locals=local_dict))
        cursor += 2
    return rows


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("log", type=Path)
    args = parser.parse_args()

    variables, equations = fixed_collision_system()
    certificate = parse_certificate(args.log, variables, len(equations))
    identity = sum((equation * coefficient for equation, coefficient in zip(equations, certificate)), sp.Integer(0)) - 1
    verified = sp.Poly(sp.expand(identity), *variables, domain=sp.QQ).is_zero
    certificate_digest = hashlib.sha256(
        "\n".join(sp.sstr(sp.expand(coefficient), order="lex") for coefficient in certificate).encode("utf-8")
    ).hexdigest()

    print("case=CONSTANT_GAMMA_E2")
    print(f"system_sha256={canonical_digest(variables, equations)}")
    print(f"certificate_sha256={certificate_digest}")
    print(f"sum_h_i_e_i_eq_one={verified}")
    if not verified:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
