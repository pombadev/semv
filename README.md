# SEMV

semv is tool written in ocaml to bump [semver](semver.org).

## Installation

Using opam

```bash
opam install semv
```

## Usage

```
semv [-major] [-minor] [-patch] +/- <input>
  -major Set major
  -minor Set minor
  -patch Set patch
  -preserve By default pre-release and build info are discarded after modification, use this to preserve them.
  -help | --help Display this list of options
```

```bash
semv -major 0.0.1 # 1.0.0
semv -minor 0.0.1 # 0.1.0
semv -patch 0.0.1 # 0.0.2

semv -major 1.0.1-alpha+74a1c58b # 2.0.1
semv -major 1.0.1-alpha+74a1c58b -preserve # 2.0.1-alpha+74a1c58b
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[Apache-2.0](https://choosealicense.com/licenses/apache-2.0/)