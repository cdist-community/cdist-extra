# cdist-extra

This is the [community maintained](https://github.com/cdist-community)
fork of [Ungleich](https://github.com/ungleich)'s [cdist](https://github.com/ungleich/cdist)
(after [f061fb1](https://github.com/ungleich/cdist/commit/f061fb168ddacc894cb6e9882ff5c8ba002fadd8)).

Work is split between four repositories:

* [cdist](https://github.com/cdist-community/cdist) - documentation, project wide issues etc.
* [cdist-core](https://github.com/cdist-community/cdist-core) - implementation of the **cdist core**.
* [cdist-conf](https://github.com/cdist-community/cdist-conf) - **essential** explorers and types.
* **cdist-extra** - **non-essential** explorers, types, scripts, tools etc (this repository).

Difference between essential and non-essential? Explorers and types which are
used to manage state of the operating system (modify files and directories,
install packages, manage services, etc.) and are not strictly related to some
specific piece of software are considered essential.

## Getting Started

See [cdist](https://github.com/cdist-community/cdist) repository.
