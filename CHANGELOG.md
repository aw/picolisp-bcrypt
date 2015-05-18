# Changelog

## 0.4.0 (2015-05-17)

  * Use 'bcrypt_checkpw' function which protects against timing attacks

## 0.3.1 (2015-05-10)

  * Use specific ref for bcrypt C lib

## 0.3.0 (2015-04-29)

  * Remove the need for git submodules
  * Add Makefile for fetching and building dependencies
  * Change default path for dependencies and shared module (.modules and .lib)
  * Adjust README.md, tests and travis-ci unit testing config

## 0.2.14 (2015-04-17)

  * Update picolisp-unit to v0.6.1

## 0.2.13 (2015-04-06)

  * Update picolisp-unit to v0.6.0

## 0.2.12 (2015-03-29)

  * Actually update picolisp-unit to v0.5.2

## 0.2.11 (2015-03-29)

  * Update picolisp-unit to v0.5.2

## 0.2.10 (2015-03-29)

  * Update picolisp-unit to v0.5.0

## 0.2.9 (2015-03-23)

  * Improve build test times
  * Prevent leaky symbols

## 0.2.8 (2015-03-19)

  * Move MODULE_INFO to module.l

## 0.2.7 (2015-03-19)

  * New format for MODULE_INFO
  * Add update.sh
  * Add note about Updating

## 0.2.6 (2015-03-19)

  * Update picolisp-unit to v0.3.0
  * Remove unused functions and variables
  * Use (assert-throws)

## 0.2.5 (2015-03-18)

  * Update picolisp-unit and change assertions

## 0.2.4 (2015-03-18)

  * Fix reversed assertions

## 0.2.3 (2015-03-18)

  * Update picolisp-unit dependency to v0.1.2

## 0.2.2 (2015-03-18)

  * Add .travis.yml for automated build tests

## 0.2.1 (2015-03-18)

  * Ensure test.l is executable

## 0.2.0 (2015-03-18)

  * Add unit tests using picolisp-unit

## 0.1.0 (2015-03-17)

  * First release - bcrypt hashing for PicoLisp
