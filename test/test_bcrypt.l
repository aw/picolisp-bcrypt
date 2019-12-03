(load "../bcrypt.l")

(prinl "^J  Testing bcrypt library functions^J")

(setq *Salt   (gensalt)
      *Hash   (hashpw "changeme" *Salt)
      *Passwd (hashpw "changeme") )

(de test-hash-factor-12 ()
  (assert-includes "$2a$12"
                        *Salt
                        "Generate a bcrypt hash with factor of 12" ) )

[execute
  '(test-hash-factor-12)

  '(assert-includes  "$2a$14"
                          (gensalt 14)
                          "Generate a bcrypt hash with factor of 14" )

  '(assert-includes  "$2a$12"
                          (gensalt 90)
                          "Does NOT generate a bcrypt hash with factor of 90" )

  '(assert-includes  *Salt
                          *Hash
                          "Generate matching bcrypt hashes" )

  '(assert-kind-of 'String
                        *Passwd
                        "Generate bcrypt password without providing a hash" )

  '(assert-t   (compare "changeme" *Passwd)
                    "Successfully compare a password and hash" )

  '(assert-nil (compare "changeme" "$2a$12$2Lgk0P5s5VsxDUM2aa/HFu/6DwHce1lbUwJ1kTm092DwEeDRHHYBy")
                    "Fail to compare a password and hash" )

  '(assert-throws  'InternalError
                        '(BcryptError . "Unable to hash password")
                        '(compare "changeme" "I have no idea what i'm doing")
                        "Throw an InternalError when trying to compare an invalid hash" )

  '(assert-equal 12
                      (car (timing))
                      "Timing a hash with the default factor of 12" )

  '(assert-t (> (cdr (timing 15)) 1)
                  "Timing a hash in more than 1 second with a factor of 15") ]
