# Contributing to AnnLite (meta-repo)

This repository only contains submodule pointers, bootstrap/update scripts,
and this documentation — there's no application code to contribute to
here directly.

- To contribute to a specific part of Ann Lite, go to that repository
  directly (see the table in README.md) and follow its own CONTRIBUTING.md.
- To propose a change to `.gitmodules` (e.g. a new repository added to the
  ecosystem), open a PR here explaining why the new repository is needed,
  consistent with the organization's "no repository without a clear
  responsibility" principle.
- To change `scripts/bootstrap.sh` or `scripts/update-all.sh`, please test
  the change against a real partial checkout (some submodules present,
  some not) before opening a PR — these scripts are explicitly designed
  to degrade gracefully, and that behavior is easy to break accidentally.
