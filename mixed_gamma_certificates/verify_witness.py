"""Verify one printed Singular lift certificate with SymPy over QQ."""

from __future__ import annotations

import hashlib
import pathlib
import runpy
import sys

if len(sys.argv) != 3:
    raise SystemExit("usage: verify_witness.py CASE LOG")

requested_case = sys.argv[1]
log_path = pathlib.Path(sys.argv[2]).resolve()
generator = pathlib.Path(__file__).with_name("independent_mixed_gamma_audit.py")

old_argv = sys.argv
sys.argv = [str(generator)]
namespace = runpy.run_path(str(generator))
sys.argv = old_argv

sp = namespace["sp"]
cases = namespace["AUDIT_CASES"]


def parse_certificate(generators, expected_rows):
    lines = log_path.read_text(encoding="utf-8").splitlines()
    start = lines.index("CERTIFICATE_MATRIX") + 1
    local_dict = {str(x): x for x in generators}
    rows = []
    cursor = start
    for index in range(1, expected_rows + 1):
        assert lines[cursor] == f"ROW {index}", (index, lines[cursor])
        rows.append(sp.sympify(lines[cursor + 1].replace("^", "**"), locals=local_dict))
        cursor += 2
    return rows


for name, equations, generators, system_digest in cases:
    slug = name.lower().replace("-", "_")
    if slug != requested_case:
        continue
    certificate = parse_certificate(generators, len(equations))
    identity = sum((e*c for e, c in zip(equations, certificate)), sp.Integer(0)) - 1
    verified = sp.Poly(identity, *generators, domain=sp.QQ).is_zero
    certificate_digest = hashlib.sha256(
        "\n".join(sp.sstr(sp.expand(c), order="lex") for c in certificate).encode()
    ).hexdigest()
    print(f"case={name}")
    print(f"system_sha256={system_digest}")
    print(f"certificate_sha256={certificate_digest}")
    print(f"sum_h_i_e_i_eq_one={verified}")
    assert verified
    break
else:
    raise AssertionError(f"unknown case: {requested_case}")
