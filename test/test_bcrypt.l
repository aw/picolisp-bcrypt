(load "../bcrypt.l")

(prinl "^J  Testing bcrypt library functions^J")

(symbols 'bcrypt)

(setq *Salt_14  (gensalt 14)
      *Salt_12  (gensalt)
      *Salt_90  (gensalt 90)
      *Hash     (hashpw "changeme" *Salt_12)
      *Passwd   (hashpw "changeme") )

(setq *Error_1  (catch 'InternalError
  (compare "changeme" "I have no idea what i'm doing") NIL ) )

(de test-hash-factor-12 ()
  (unit~assert-equal  *Salt_12
                      (sub? "$2a$12" *Salt_12)
                      "Generate a bcrypt hash with factor of 12" ) )

[unit~execute
  '(test-hash-factor-12)

  '(unit~assert-equal *Salt_14
                      (sub? "$2a$14" *Salt_14)
                      "Generate a bcrypt hash with factor of 14" )

  '(unit~assert-equal *Salt_90
                      (sub? "$2a$12" *Salt_90)
                      "Does NOT generate a bcrypt hash with factor of 90" )

  '(unit~assert-equal (sub? *Salt_12 *Hash)
                      *Hash
                      "Generate matching bcrypt hashes" )

  '(unit~assert-equal *Passwd
                      *Passwd
                      "Generate bcrypt password without providing a hash" )

  '(unit~assert-equal (compare "changeme" *Passwd)
                      T
                      "Successfully compare a password and hash" )

  '(unit~assert-equal (compare "changeme" "$2a$12$2Lgk0P5s5VsxDUM2aa/HFu/6DwHce1lbUwJ1kTm092DwEeDRHHYBy")
                      NIL
                      "Fail to compare a password and hash" )

  '(unit~assert-equal *Error_1
                      '(BcryptError . "Unable to hash password")
                      "Throw an InternalError when trying to compare an invalid hash")

  '(unit~assert-equal (car (timing))
                      12
                      "Timing a hash with the default factor of 12")

  '(unit~assert-equal (> (cdr (timing 15)) 1)
                      T
                      "Timing a hash in more than 1 second with a factor of 15") ]