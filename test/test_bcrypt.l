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
  (unit~assert-includes "$2a$12"
                        *Salt_12
                        "Generate a bcrypt hash with factor of 12" ) )

[unit~execute
  '(test-hash-factor-12)

  '(unit~assert-includes  "$2a$14"
                          *Salt_14
                          "Generate a bcrypt hash with factor of 14" )

  '(unit~assert-includes  "$2a$12"
                          *Salt_90
                          "Does NOT generate a bcrypt hash with factor of 90" )

  '(unit~assert-includes  *Salt_12
                          *Hash
                          "Generate matching bcrypt hashes" )

  '(unit~assert-kind-of 'String
                        *Passwd
                        "Generate bcrypt password without providing a hash" )

  '(unit~assert-t   (compare "changeme" *Passwd)
                    "Successfully compare a password and hash" )

  '(unit~assert-nil (compare "changeme" "$2a$12$2Lgk0P5s5VsxDUM2aa/HFu/6DwHce1lbUwJ1kTm092DwEeDRHHYBy")
                    "Fail to compare a password and hash" )

  '(unit~assert-throws  'InternalError
                        '(BcryptError . "Unable to hash password")
                        '(compare "changeme" "I have no idea what i'm doing")
                        "Throw an InternalError when trying to compare an invalid hash" )

  '(unit~assert-equal 12
                      (car (timing))
                      "Timing a hash with the default factor of 12" )

  '(unit~assert-t (> (cdr (timing 15)) 1)
                  "Timing a hash in more than 1 second with a factor of 15") ]
