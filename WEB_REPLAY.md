# Lean Web replay note

Date: July 21, 2026.

The byte-identical `DegreeHunt.lean` file was loaded into the official Lean Web
editor using its “Latest Mathlib with Lean v4.33.0-rc1” environment. The editor
reported zero error and zero warning markers, with five informational markers
corresponding to the five `#print axioms` commands.

The byte-identical `DegreeHuntMathlib.lean` file was then loaded in the same
Lean 4.33.0-rc1 environment. After elaboration, the editor reported zero error
and zero warning markers.

This is a meaningful independent web replay at the exact Lean version, but the
web editor labels Mathlib as “Latest” rather than the historical pinned commit.
The GitHub Actions workflow in this bundle is therefore the definitive exact
replay for `DegreeHuntMathlib.lean`.
