# bcrypt hashing for PicoLisp

[![GitHub release](https://img.shields.io/github/release/aw/picolisp-bcrypt.svg)](https://img.shields.io/github/release/aw/picolisp-bcrypt) [![Dependency](https://img.shields.io/badge/[deps] bcrypt-master-ff69b4.svg)](https://github.com/rg3/bcrypt.git) [![Dependency](https://img.shields.io/badge/[deps] picolisp--unit-v0.1.1-ff69b4.svg)](https://github.com/aw/picolisp-unit.git)

This library can be used to hash strings (ex: passwords) using bcrypt in [PicoLisp](http://picolisp.com/).

![picolisp-bcrypt](https://cloud.githubusercontent.com/assets/153401/6683641/cdb9492e-cc80-11e4-8c5c-24ba9504b90c.png)

  1. [Requirements](#requirements)
  2. [Getting Started](#getting-started)
  3. [Usage](#usage)
  4. [Examples](#examples)
  5. [Testing](#testing)
  6. [Contributing](#contributing)
  7. [License](#license)

# Requirements

  * PicoLisp 64-bit v3.1.9+
  * Git
  * UNIX/Linux development/build tools (gcc, make/gmake, etc..)

# Getting Started

These FFI bindings require the [bcrypt C library](https://github.com/rg3/bcrypt.git), compiled as a shared library. It is included here as a [git submodule](http://git-scm.com/book/en/v2/Git-Tools-Submodules).

  1. Type `./build.sh` to pull and compile the _bcrypt C Library_.
  2. Include `bcrypt.l` in your project
  3. Try the [examples](#examples) below

### Linking and Paths

Once compiled, the shared library is symlinked as:

    lib/libbcrypt.so -> vendor/bcrypt/libbcrypt.so

The `bcrypt.l` file searches for `lib/libbcrypt.so`, relative to its current directory.

# Usage

All functions are publicly accessible and namespaced with `(symbols 'bcrypt)` (or the prefix: `bcrypt~`), but only the following are necessary:

  * **(gensalt Factor)** generates a salt to be used for hashing a string
    - `Factor` _Number_: a Number between 4 and 31, defaults to `12` otherwise
  * **(hashpw Passwd Salt)** hashes a string with the salt provided
    - `Passwd` _String_: the String to be hashed
    - `Salt` _String_ or _Number (optional)_: a hash String or Number used as a cost Factor (will generate a salt automatically if a Number is provided)
  * **(compare Passwd Hash)** a predicate which compares the password and hash. Returns `NIL` or `T`.
    - `Passwd` _String_: the password String
    - `Hash` _String_: the hashed String of the password
  * **(timing Factor)** calculates the timing of a password hashing, in seconds. Returns the factor in `car` and seconds in `cdr`

### Notes

  * The default cost Factor is `12`.
  * As rule of thumb, when using bcrypt to hash passwords, it should take _at least 1 second_ per hash. Adjust the cost Factor based on the result of a few (timing) runs.
  * The `'InternalError` message will be thrown if there's an error.

# Examples

### (gensalt Factor)

```lisp
pil +

(load "bcrypt.l")

(symbols 'bcrypt)
(gensalt)
-> "$2a$12$mQn1fUDeEZFW74KD5kU6g."

(gensalt 14)
-> "$2a$14$kjOSmjZeLsBdru7NRPEmQu"
```

### (hashpw Passwd Salt)

```lisp
pil +

(load "bcrypt.l")

(symbols 'bcrypt)
(hashpw "changeme")
-> "$2a$12$mmxN/qk8yvfjCx./KXtgfuqnUFsXjYv1ZTZmkMtdQ94rTDngiXpsq"

(hashpw "changeme" 14)
-> "$2a$14$gZLc8eII8kCbXgFp2rUcv.PPr/oPioojVy0yP0HMU6z2La.v4pEnG"

(hashpw "changeme" "$2a$14$kjOSmjZeLsBdru7NRPEmQu")
-> "$2a$14$kjOSmjZeLsBdru7NRPEmQuL5eU5YN4Yb48bD1A0Pxzwu/3G/7kwBy"
```

### (compare Passwd Hash)

```lisp
pil +

(load "bcrypt.l")

(symbols 'bcrypt)
(compare "changeme" "$2a$14$kjOSmjZeLsBdru7NRPEmQuL5eU5YN4Yb48bD1A0Pxzwu/3G/7kwBy")
-> T

(compare "changeme" "$2a$12$2Lgk0P5s5VsxDUM2aa/HFu/6DwHce1lbUwJ1kTm092DwEeDRHHYBy")
-> NIL

(catch 'InternalError (compare "changeme" "I have no idea what i'm doing"))
-> (BcryptError . "Unable to hash password")
```

### (timing Factor)

```lisp
pil +

(load "bcrypt.l")

(symbols 'bcrypt)
(timing)
-> (12 . 0)

(timing 15)
-> (15 . 4)
```

# Testing

This library now comes with full [unit tests](https://github.com/aw/picolisp-unit). To run the tests, run:

    ./test.l

# Contributing

If you find any bugs or issues, please [create an issue](https://github.com/aw/picolisp-bcrypt/issues/new).

If you want to improve this library, please make a pull-request.

# License

[MIT License](LICENSE)

Copyright (c) 2015 Alexander Williams, Unscramble <license@unscramble.jp>
