# bcrypt.l
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Alexander Williams, Unscramble <license@unscramble.jp>

(symbols 'bcrypt 'pico)

(local MODULE_INFO *Bcrypt *BCRYPT_HASHSIZE *Work_factor *Salt_struct)
(local bcrypt-gensalt bcrypt-hashpw throw-error epoch to-string)

(load (pack (car (file)) "module.l"))

(setq
  *Bcrypt           (pack (car (file)) ".lib/libbcrypt.so")

  *BCRYPT_HASHSIZE  64
  *Work_factor      12 )

(setq *Salt_struct '(`*BCRYPT_HASHSIZE B . `*BCRYPT_HASHSIZE))


# ffi-bindings
(de bcrypt-gensalt (Factor &salt)
  (use Salt
    (cons
        (native `*Bcrypt "bcrypt_gensalt" 'I Factor (cons 'Salt &salt 0))
        Salt ]

(de bcrypt-hashpw (Passwd Salt &hash)
  (use Hash
    (cons
        (native `*Bcrypt "bcrypt_hashpw" 'I Passwd Salt (cons 'Hash &hash 0))
        Hash ]

(de bcrypt-checkpw (Passwd Hash)
  (native `*Bcrypt "bcrypt_checkpw" 'I Passwd Hash) )

# internal
(de throw-error (Message)
  (throw 'InternalError (cons 'BcryptError Message)) )

[de epoch ()
  (let Epoch (native "@" "time" 'I 0)
    (if (ge0 Epoch)
        @
        (throw-error "Unable to obtain UNIX Epoch") ]

[de to-string (Hash)
  (pack (mapcar char (cdr Hash) ]


# public
[de gensalt (Factor)
  (default Factor *Work_factor)

  (let Result (bcrypt-gensalt Factor *Salt_struct)
    (if (n0 (car Result))
            (throw-error "Unable to generate salt")
            (to-string Result) ]

[de hashpw (Passwd Salt)
  (default Salt *Work_factor)

  (let Hash (if (num? Salt)
                (gensalt Salt)
                Salt )

    (let Result (bcrypt-hashpw Passwd Hash *Salt_struct)
      (if (n0 (car Result))
              (throw-error "Unable to hash password")
              (to-string Result) ]

[de compare (Passwd Hash)
  (let Matched (bcrypt-checkpw Passwd Hash)
    (case Matched
      (-1 (throw-error "Unable to hash password"))
      (0 T) ]

[de timing (Factor)
  (default Factor *Work_factor)

  (let Start (epoch)
    (hashpw "speed test to hash a password" Factor)
    (let End (epoch)
      (cons Factor (- End Start)) ]
